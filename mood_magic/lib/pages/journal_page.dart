import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  final List<String> journalEntries;

  const JournalPage({Key? key, required this.journalEntries}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  late PageController _pageController;
  late TextEditingController _currentEntryController;
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.journalEntries.length;
    _pageController = PageController(initialPage: _currentPageIndex);
    _currentEntryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Journal'),
        backgroundColor: Color.fromRGBO(139, 76, 252, 50),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
            child: Center(
              child: Text(
                _getCurrentDate(_currentPageIndex),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 400, // Set the height as needed
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.journalEntries.length + 1,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                if (index == widget.journalEntries.length) {
                  // Current page (editable)
                  return buildCurrentJournalEntry();
                } else {
                  // Previous entries (read-only)
                  return buildJournalEntry(widget.journalEntries[widget.journalEntries.length - 1 - index]);
                }
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _saveCurrentEntry();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget buildCurrentJournalEntry() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
      color: Colors.white, // Set the background color to white
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
    child: Column(
      children: [
        Container(
          height: 60, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Color.fromRGBO(139, 76, 252, 50), // Purple background color
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)), // Rounded top corners
          ),
          child: Center(
            child: Text(
              'Write your thought for the day here',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _currentEntryController,
              maxLines: null,
              expands: true,
              style: TextStyle(color: Colors.black), // Text color
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...',
                border: InputBorder.none, // Remove border
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget buildJournalEntry(String entry) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 60, // Adjust the height as needed
            child: Center(
              child: Text(
                _getCurrentDate(widget.journalEntries.length - widget.journalEntries.indexOf(entry) - 1),
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(entry.isNotEmpty ? entry : 'Today I was in a great mood!'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentDate(int index) {
    DateTime currentDate = DateTime.now().subtract(Duration(days: _currentPageIndex - index));
    return "${currentDate.day}/${currentDate.month}/${currentDate.year}";
  }

  void _saveCurrentEntry() {
    String currentEntryText = _currentEntryController.text;
    if (currentEntryText.isNotEmpty) {
      // Save the entry to the list
      setState(() {
        widget.journalEntries.add(currentEntryText);
      });
    }
  }
}
