import 'dart:math';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late SharedPreferences _prefs;
  int _selectedMoodIndex = 0; 
  Map<DateTime, Color> _moodColorsMap = {};

  final List<String> moodEmojis = ['😊', '😢', '😡', '😎']; // Sample mood emojis
  final List<Color> moodColors = [
    Colors.green, // Happy
    Colors.blue, // Sad
    Colors.red, // Angry
    Colors.orange, // Cool
  ];

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;

    // Initialize shared preferences
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _selectedDay = DateTime.parse(_prefs.getString('selectedDay') ?? '');
        _selectedMoodIndex = _prefs.getInt('selectedMoodIndex') ?? 0;
        _moodColorsMap = _getMoodColorsFromPrefs();

        // Fill in previous days with random mood emojis
        _fillPreviousDays();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Color.fromRGBO(139, 76, 252, 50),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  moodEmojis[_selectedMoodIndex],
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _selectPreviousMood();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    _selectNextMood();
                  },
                ),
              ],
            ),
          ),
          TableCalendar(
            headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
            rowHeight: 50,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(day, _selectedDay);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _prefs.setString('selectedDay', _selectedDay.toIso8601String());
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
           
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (_moodColorsMap.containsKey(day)) {
                  return Text(
                    _getEmojiForColor(_moodColorsMap[day]!),
                    style: TextStyle(fontSize: 16),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          // "Track" button
          FloatingActionButton(
            onPressed: () {
              _trackMood();
            },
            child: Icon(Icons.track_changes),
          ),
        ],
      ),
    );
  }

  void _selectPreviousMood() {
    setState(() {
      _selectedMoodIndex = (_selectedMoodIndex - 1) % moodEmojis.length;
      _prefs.setInt('selectedMoodIndex', _selectedMoodIndex);
    });
  }

  void _selectNextMood() {
    setState(() {
      _selectedMoodIndex = (_selectedMoodIndex + 1) % moodEmojis.length;
      _prefs.setInt('selectedMoodIndex', _selectedMoodIndex);
    });
  }

  void _trackMood() {
    setState(() {
      _moodColorsMap[_selectedDay] = moodColors[_selectedMoodIndex];
    });

    
    _saveMoodColorsToPrefs();

    print('Mood colors saved: $_moodColorsMap');
  }

  void _fillPreviousDays() {
  DateTime currentDate = DateTime.now();
  DateTime firstDate = DateTime.utc(2023, 1, 1);

  
  for (DateTime date = firstDate; date.isBefore(currentDate); date = date.add(Duration(days: 1))) {
    if (!_moodColorsMap.containsKey(date)) {
      
      int randomMoodIndex = Random().nextInt(moodEmojis.length);

     
      _moodColorsMap[date] = moodColors[randomMoodIndex];
    }
  }

  
  _saveMoodColorsToPrefs();
}

  Map<DateTime, Color> _getMoodColorsFromPrefs() {
    Map<DateTime, Color> moodColorsMap = {};
    List<String>? savedColors = _prefs.getStringList('moodColors');
    if (savedColors != null) {
      savedColors.forEach((savedColor) {
        List<String> parts = savedColor.split(':');
        if (parts.length == 2) {
          DateTime date = DateTime.parse(parts[0]);
          Color color = _colorFromHex(parts[1]);
          moodColorsMap[date] = color;
        }
      });
    }
    return moodColorsMap;
  }

  void _saveMoodColorsToPrefs() {
    List<String> colorsList = [];
    _moodColorsMap.forEach((date, color) {
      String dateString = date.toIso8601String();
      String colorString = _colorToHex(color);
      String entry = '$dateString:$colorString';
      colorsList.add(entry);
    });
    _prefs.setStringList('moodColors', colorsList);
  }

  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  String _colorToHex(Color color) {
    return "#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}";
  }

  String _getEmojiForColor(Color color) {
    if (color == Colors.green) {
      return '😊';
    } else if (color == Colors.blue) {
      return '😢';
    } else if (color == Colors.red) {
      return '😡';
    } else if (color == Colors.orange) {
      return '😎';
    } else {
      return '❓';
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: CalendarPage(),
  ));
}
