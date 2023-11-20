import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentMood = '😊'; // Default mood is happiness

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {
                      _showTimerDialog(context);
                    },
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalPage()),
                      );
                    },
                    color: Colors.black,
                  ),
                ],
              ),
              buildCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Current Mood: ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: _showMoodSelectionDialog,
                          child: Text(
                            currentMood,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(139, 76, 252, 50), // Change color as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                       
                        SizedBox(width: 8),
                        Icon(Icons.edit, size: 24, color:  Color.fromRGBO(139, 76, 252, 50)), // Use the 'edit' icon
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              buildCard(
                child: Text(
                  _getMoodQuote(currentMood),
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildRecommendationSection('Books', getRecommendations(currentMood, 'Books')),
              SizedBox(height: 20),
              buildRecommendationSection('Movies', getRecommendations(currentMood, 'Movies')),
              SizedBox(height: 20),
              buildRecommendationSection('Songs', getRecommendations(currentMood, 'Songs')),
            ],
          ),
        ),
      ),
    );
  }


  IconData getMoodIcon(String mood) {
    switch (mood) {
      case '😊':
        return Icons.sentiment_very_satisfied;
      case '😢':
        return Icons.sentiment_very_dissatisfied;
      case '😎':
        return Icons.sentiment_satisfied;
      case '😡':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
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
              for (var i = 0; i < recommendations.length && i < 2; i++)
                RecommendationCard(recommendation: recommendations[i]),
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
    int selectedTime = 5;

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

  void _showMoodSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Mood'),
        content: Column(
          children: [
            _buildMoodSelectionButton('😊', 'Happiness'),
            _buildMoodSelectionButton('😢', 'Sadness'),
            _buildMoodSelectionButton('😎', 'Cool'),
            _buildMoodSelectionButton('😡', 'Anger'),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelectionButton(String mood, String label) {
    return TextButton(
      onPressed: () {
        setState(() {
          currentMood = mood;
        });
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Text(
            mood,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  String _getMoodQuote(String mood) {
    switch (mood) {
      case '😊':
        return '"Stay positive, work hard, make it happen."';
      case '😢':
        return '"It\'s okay not to be okay."';
      case '😎':
        return '"Stay cool and keep going."';
      case '😡':
        return '"Don\'t let anger control you."';
      default:
        return '';
    }
  }

  List<Recommendation> getRecommendations(String mood, String category) {
    switch (mood) {
      case '😊':
        return _getHappyRecommendations(category);
      case '😢':
        return _getSadRecommendations(category);
      case '😎':
        return _getCoolRecommendations(category);
      case '😡':
        return _getAngryRecommendations(category);
      default:
        return [];
    }
  }

  List<Recommendation> _getHappyRecommendations(String category) {
    switch (category) {
      case 'Books':
        return [
          Recommendation(
            title: 'The Happiness Project',
            icon: Icons.book,
            description: 'A book about finding happiness in everyday life.',
          ),
          Recommendation(
            title: 'The Power of Now',
            icon: Icons.book,
            description: 'A guide to spiritual enlightenment and living in the present moment.',
          ),
          // Add more happy book recommendations as needed
        ];
      case 'Movies':
        return [
          Recommendation(
            title: 'The Pursuit of Happyness',
            icon: Icons.movie,
            description: 'A biographical drama about overcoming life challenges.',
          ),
          Recommendation(
            title: 'La La Land',
            icon: Icons.movie,
            description: 'A musical that celebrates dreams and the pursuit of passion.',
          ),
          // Add more happy movie recommendations as needed
        ];
      case 'Songs':
        return [
          Recommendation(
            title: 'Happy - Pharrell Williams',
            icon: Icons.music_note,
            description: 'An upbeat song that spreads happiness.',
          ),
          Recommendation(
            title: 'Don\'t Worry, Be Happy - Bobby McFerrin',
            icon: Icons.music_note,
            description: 'A classic song with a positive message.',
          ),
          // Add more happy song recommendations as needed
        ];
      default:
        return [];
    }
  }

  List<Recommendation> _getSadRecommendations(String category) {
  switch (category) {
    case 'Books':
      return [
        Recommendation(
          title: 'The Fault in Our Stars',
          icon: Icons.book,
          description: 'A heartbreaking novel about two cancer-stricken teenagers falling in love.',
        ),
        Recommendation(
          title: 'A Little Life',
          icon: Icons.book,
          description: 'A novel that explores the profound effects of trauma and the power of friendship.',
        ),
        // Add more sad book recommendations as needed
      ];
    case 'Movies':
      return [
        Recommendation(
          title: 'Schindler\'s List',
          icon: Icons.movie,
          description: 'A powerful film depicting the true story of a man who saved hundreds of Jews during the Holocaust.',
        ),
        Recommendation(
          title: 'Life is Beautiful',
          icon: Icons.movie,
          description: 'An Italian film about a father\'s attempt to shelter his son from the horrors of a concentration camp.',
        ),
        // Add more sad movie recommendations as needed
      ];
    case 'Songs':
      return [
        Recommendation(
          title: 'Someone Like You - Adele',
          icon: Icons.music_note,
          description: 'A soulful song about heartbreak and lost love.',
        ),
        Recommendation(
          title: 'Tears in Heaven - Eric Clapton',
          icon: Icons.music_note,
          description: 'A poignant song expressing grief and loss.',
        ),
        // Add more sad song recommendations as needed
      ];
    default:
      return [];
  }
}

List<Recommendation> _getCoolRecommendations(String category) {
  switch (category) {
    case 'Books':
      return [
        Recommendation(
          title: 'The Girl with the Dragon Tattoo',
          icon: Icons.book,
          description: 'A gripping mystery novel with a cool and resourceful protagonist.',
        ),
        Recommendation(
          title: 'Ready Player One',
          icon: Icons.book,
          description: 'A science fiction adventure set in a virtual reality world.',
        ),
        // Add more cool book recommendations as needed
      ];
    case 'Movies':
      return [
        Recommendation(
          title: 'The Matrix',
          icon: Icons.movie,
          description: 'A sci-fi classic that explores the concept of reality and virtual worlds.',
        ),
        Recommendation(
          title: 'Drive',
          icon: Icons.movie,
          description: 'A stylish and cool film about a stuntman who moonlights as a getaway driver.',
        ),
        // Add more cool movie recommendations as needed
      ];
    case 'Songs':
      return [
        Recommendation(
          title: 'Smooth Operator - Sade',
          icon: Icons.music_note,
          description: 'A smooth and cool jazz-pop song.',
        ),
        Recommendation(
          title: 'Chill Out - Ray Charles',
          icon: Icons.music_note,
          description: 'A laid-back and cool song by the legendary Ray Charles.',
        ),
        // Add more cool song recommendations as needed
      ];
    default:
      return [];
  }
}

List<Recommendation> _getAngryRecommendations(String category) {
  switch (category) {
    case 'Books':
      return [
        Recommendation(
          title: 'Fight Club',
          icon: Icons.book,
          description: 'A novel that explores the disillusionment and anger of modern life.',
        ),
        Recommendation(
          title: 'The Girl on the Train',
          icon: Icons.book,
          description: 'A psychological thriller with themes of betrayal and anger.',
        ),
        // Add more angry book recommendations as needed
      ];
    case 'Movies':
      return [
        Recommendation(
          title: 'American History X',
          icon: Icons.movie,
          description: 'A film that delves into the roots of racism and anger in America.',
        ),
        Recommendation(
          title: 'Taxi Driver',
          icon: Icons.movie,
          description: 'A classic film depicting the descent into anger and violence.',
        ),
        // Add more angry movie recommendations as needed
      ];
    case 'Songs':
      return [
        Recommendation(
          title: 'Killing in the Name - Rage Against the Machine',
          icon: Icons.music_note,
          description: 'A powerful protest song expressing anger against authority.',
        ),
        Recommendation(
          title: 'Break Stuff - Limp Bizkit',
          icon: Icons.music_note,
          description: 'An intense song reflecting frustration and anger.',
        ),
        // Add more angry song recommendations as needed
      ];
    default:
      return [];
  }
}
}

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
        backgroundColor:  Color.fromRGBO(139, 76, 252, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                _showTimerDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTimerDialog(BuildContext context) {
    int selectedTime = 5;

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
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
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
