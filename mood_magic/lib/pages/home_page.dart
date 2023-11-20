import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timer Icon (Aligned evenly with the journal icon)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {
                      // Add logic to set a timer for meditation
                      _showTimerDialog(context);
                    },
                    color: Colors.black,
                  ),
                  // + Icon (Moved to the top right)
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Open the journal page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalPage()),
                      );
                    },
                    color: Colors.black,
                  ),
                ],
              ),

              // Current Mood
              buildCard(
                child: Text(
                  'Current Mood: Happy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Daily Quote
              buildCard(
                child: Text(
                  '"Stay positive, work hard, make it happen."',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Book Recommendations
              buildRecommendationSection('Books', [
                Recommendation(
                  title: 'Book 1: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 1.',
                ),
                Recommendation(
                  title: 'Book 2: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 2.',
                ),
                Recommendation(
                  title: 'Book 3: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 3.',
                ),
                Recommendation(
                  title: 'Book 4: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 4.',
                ),
                Recommendation(
                  title: 'Book 5: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 5.',
                ),
                Recommendation(
                  title: 'Book 6: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 6.',
                ),
                Recommendation(
                  title: 'Book 7: Title',
                  icon: Icons.book,
                  description: 'Short description for Book 7.',
                ),
              ]),

              SizedBox(height: 20),

              // Movie Recommendations
              buildRecommendationSection('Movies', [
                Recommendation(
                  title: 'Movie 1: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 1.',
                ),
                Recommendation(
                  title: 'Movie 2: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 2.',
                ),
                Recommendation(
                  title: 'Movie 3: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 3.',
                ),
                Recommendation(
                  title: 'Movie 4: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 4.',
                ),
                Recommendation(
                  title: 'Movie 5: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 5.',
                ),
                Recommendation(
                  title: 'Movie 6: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 6.',
                ),
                Recommendation(
                  title: 'Movie 7: Title',
                  icon: Icons.movie,
                  description: 'Short description for Movie 7.',
                ),
              ]),

              SizedBox(height: 20),

              // Song Recommendations
              buildRecommendationSection('Songs', [
                Recommendation(
                  title: 'Song 1: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 1.',
                ),
                Recommendation(
                  title: 'Song 2: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 2.',
                ),
                Recommendation(
                  title: 'Song 3: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 3.',
                ),
                Recommendation(
                  title: 'Song 4: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 4.',
                ),
                Recommendation(
                  title: 'Song 5: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 5.',
                ),
                Recommendation(
                  title: 'Song 6: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 6.',
                ),
                Recommendation(
                  title: 'Song 7: Title',
                  icon: Icons.music_note,
                  description: 'Short description for Song 7.',
                ),
              ]),

              // ... Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRecommendationSection(String category, List<Recommendation> recommendations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: Text(
            '$category Recommendations',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              // Displaying recommendations using cards
              for (var i = 0; i < recommendations.length && i < 2; i++)
                RecommendationCard(recommendation: recommendations[i]),

              // Dropdown arrow
              recommendations.length > 2
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 40,
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        items: [
                          for (int i = 2; i < recommendations.length; i++)
                            DropdownMenuItem(
                              value: recommendations[i],
                              child: Text(
                                recommendations[i].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          // Handle dropdown item selection
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCard({required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }

  void _showTimerDialog(BuildContext context) {
    int selectedTime = 5; // Default time in minutes

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Meditation Timer'),
        content: Column(
          children: [
            Text('Select time in minutes:'),
            SizedBox(height: 10),
            DropdownButton<int>(
              value: selectedTime,
              items: List.generate(
                31,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text('$index'),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  selectedTime = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startMeditationTimer(context, selectedTime);
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }

  void _startMeditationTimer(BuildContext context, int minutes) async {
    await Future.delayed(Duration(minutes: minutes));

    // Show congratulations popup
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations!'),
        content: Text('You have completed your meditation session.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
        backgroundColor: Colors.purple, // Set tab color to purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Journal Content
            Expanded(
              child: Container(
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
                child: TextField(
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Write your thoughts here...',
                    border: OutlineInputBorder(),
                    filled: true,  // Added to fill the background
                    fillColor: Colors.white,  // Set background color to white
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Timer Icon (Moved to the top left)
            IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                // Add logic to set a timer for meditation
                _showTimerDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTimerDialog(BuildContext context) {
    int selectedTime = 5; // Default time in minutes

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Meditation Timer'),
        content: Column(
          children: [
            Text('Select time in minutes:'),
            SizedBox(height: 10),
            DropdownButton<int>(
              value: selectedTime,
              items: List.generate(
                31,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text('$index'),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  selectedTime = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startMeditationTimer(context, selectedTime);
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }

  void _startMeditationTimer(BuildContext context, int minutes) async {
    await Future.delayed(Duration(minutes: minutes));

    // Show congratulations popup
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations!'),
        content: Text('You have completed your meditation session.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final Recommendation recommendation;

  const RecommendationCard({Key? key, required this.recommendation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () => showRecommendationDetails(context, recommendation),
          child: Column(
            children: [
              Icon(recommendation.icon, size: 40, color: Colors.purpleAccent),
              SizedBox(height: 8),
              Text(
                recommendation.title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRecommendationDetails(BuildContext context, Recommendation recommendation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(recommendation.title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100, // Adjust the height as needed
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey, // Placeholder color, change as needed
                borderRadius: BorderRadius.circular(8),
              ),
              // You can replace the child with an Image.network if you have actual URLs
              child: Icon(recommendation.icon, size: 60, color: Colors.purpleAccent),
            ),
            SizedBox(height: 8),
            Text(recommendation.description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class Recommendation {
  final String title;
  final IconData icon;
  final String description;

  Recommendation({
    required this.title,
    required this.icon,
    required this.description,
  });
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
