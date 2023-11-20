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
  int _selectedMoodIndex = 0; // Index for the selected mood emoji
  Map<DateTime, Color> _moodColorsMap = {};

  final List<String> moodEmojis = ['😊', '😢', '😡', '😎']; // Sample mood emojis
  final List<Color> moodColors = [
    Colors.green, // Happy
    Colors.blue, // Sad
    Colors.red, // Angry
    Colors.orange, // Cool
  ]; // Sample mood colors

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Display selected mood circle
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: moodColors[_selectedMoodIndex],
                  ),
                ),
                SizedBox(width: 8),
                // Emoji selection arrow buttons
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _selectPreviousMood();
                  },
                ),
                Text(
                  moodEmojis[_selectedMoodIndex],
                  style: TextStyle(fontSize: 20),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 50,
              headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
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
              // Add the TableCellBuilder to customize each day cell
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (_moodColorsMap.containsKey(day)) {
                    return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _moodColorsMap[day],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
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
  }
}

void main() {
  runApp(MaterialApp(
    home: CalendarPage(),
  ));
}