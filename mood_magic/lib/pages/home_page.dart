import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showBookDropdown = false;
  bool showMovieDropdown = false;
  bool showSongDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.purple[100]!],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Mood
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
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
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
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
                  'Book 1: Title',
                  'Book 2: Title',
                  'Book 3: Title',
                  'Book 4: Title',
                  'Book 5: Title',
                  'Book 6: Title',
                  'Book 7: Title',
                ], showBookDropdown, () {
                  setState(() {
                    showBookDropdown = !showBookDropdown;
                  });
                }),

                SizedBox(height: 20),

                // Movie Recommendations
                buildRecommendationSection('Movies', [
                  'Movie 1: Title',
                  'Movie 2: Title',
                  'Movie 3: Title',
                  'Movie 4: Title',
                  'Movie 5: Title',
                  'Movie 6: Title',
                  'Movie 7: Title',
                ], showMovieDropdown, () {
                  setState(() {
                    showMovieDropdown = !showMovieDropdown;
                  });
                }),

                SizedBox(height: 20),

                // Song Recommendations
                buildRecommendationSection('Songs', [
                  'Song 1: Title',
                  'Song 2: Title',
                  'Song 3: Title',
                  'Song 4: Title',
                  'Song 5: Title',
                  'Song 6: Title',
                  'Song 7: Title',
                ], showSongDropdown, () {
                  setState(() {
                    showSongDropdown = !showSongDropdown;
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecommendationSection(
    String category,
    List<String> recommendations,
    bool showDropdown,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$category Recommendations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Dropdown arrow
              recommendations.length > 3
                  ? DropdownArrowWidget(
                      showDropdown: showDropdown,
                      onTap: onTap,
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(height: 12),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          height: showDropdown ? 190 : null,
          child: Column(
            children: [
              // Displaying recommendations using cards
              for (int i = 0; i < recommendations.length; i++)
                RecommendationCard(
                  recommendation: recommendations[i],
                  onTap: () {
                    // Handle recommendation item click
                    showBookDialog(recommendations[i]);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  void showBookDialog(String recommendation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Book Recommendation'),
          content: Column(
            children: [
              // Use a random icon as the picture (replace with actual URLs)
              Icon(Icons.book, size: 60, color: Colors.purple),
              SizedBox(height: 10),
              // Sample summary for each recommendation (replace with actual data)
              Text(
                'Summary: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String recommendation;
  final VoidCallback onTap;

  const RecommendationCard({
    Key? key,
    required this.recommendation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            recommendation,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownArrowWidget extends StatelessWidget {
  final bool showDropdown;
  final VoidCallback onTap;

  const DropdownArrowWidget({
    Key? key,
    required this.showDropdown,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: showDropdown ? Matrix4.rotationZ(0.5) : Matrix4.rotationZ(0),
        child: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
