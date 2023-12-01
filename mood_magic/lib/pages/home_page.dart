import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  PageController _pageController = PageController();

  String currentMood = '😊';
 List<String> journalEntries = []; // Change this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color here
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
                    onPressed: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JournalPage(journalEntries: journalEntries),
                        ),
                      );
                      if (result != null && result is String) {
                        setState(() {
                          journalEntries.add(result);
                        });
                      }
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
                              color: Color.fromRGBO(139, 76, 252, 50),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(Icons.edit,
                            size: 24, color: Color.fromRGBO(139, 76, 252, 50)),
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
              buildRecommendationSection(
                  'Books', getRecommendations(currentMood, 'Books')),
              SizedBox(height: 20),
              buildRecommendationSection(
                  'Movies', getRecommendations(currentMood, 'Movies')),
              SizedBox(height: 20),
              buildRecommendationSection(
                  'Songs', getRecommendations(currentMood, 'Songs')),
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
  double containerHeight = 250.0; 
  double containerWidth = 150.0; 

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 8),
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
        height: containerHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            return Container(
              width: containerWidth,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: RecommendationCard(recommendation: recommendations[index]),
            );
          },
        ),
      ),
    ],
  );
}

  Widget buildCard({required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15),
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
            imageUrl: 'lib/images/thp.png',
            description: 'A book about finding happiness in everyday life.',
          ),
          Recommendation(
            title: 'The Power of Now',
            imageUrl: 'lib/images/tpon.png',
            description:
                'A guide to spiritual enlightenment and living in the present moment.',
          ),
          Recommendation(
            title: 'The Remains of the Day',
            imageUrl: 'lib/images/trotd.png',
            description:
                'A poignant novel about an English butler reflecting on a life of service and the changing world around him.',
          ),
        ];
      case 'Movies':
        return [
          Recommendation(
            title: 'The Pursuit of Happyness',
            imageUrl: 'lib/images/tpoh.png',
            description:
                'A biographical drama about overcoming life challenges.',
          ),
          Recommendation(
            title: 'La La Land',
            imageUrl: 'lib/images/lll.png',
            description:
                'A musical that celebrates dreams and the pursuit of passion.',
          ),
          Recommendation(
            title: 'Amour',
            imageUrl: 'lib/images/amour.png',
            description:
                'A deeply moving French film that delves into the complexities of love, aging, and mortality.',
          ),
        ];
      case 'Songs':
        return [
          Recommendation(
            title: 'Happy - Pharrell Williams',
            imageUrl: 'lib/images/happy.png',
            description: 'An upbeat song that spreads happiness.',
          ),
          Recommendation(
            title: 'Don\'t Worry, Be Happy - Bobby McFerrin',
            imageUrl: 'lib/images/dwbh.png',
            description: 'A classic song with a positive message.',
          ),
          Recommendation(
            title: 'Whats Going on - Marvin Gay',
            imageUrl: 'lib/images/wgo.png',
            description:
                'A soulful and socially conscious anthem that remains relevant, addressing themes of war and injustice.',
          ),
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
            title: 'The Alchemist',
            imageUrl: 'lib/images/ta.png',
            description:
                'A philosophical novel that tells the story of Santiago, a shepherd boy, on his journey to find his personal legend and discover the meaning of life.',
          ),
          Recommendation(
            title: 'A Little Life',
            imageUrl: 'lib/images/all.png',
            description:
                'A novel that explores the profound effects of trauma and the power of friendship.',
          ),
          Recommendation(
            title: 'Never Let Me Go',
            imageUrl: 'lib/images/nlmg.png',
            description:
                'Kazuo Ishiguros haunting exploration of love, loss, and the ethics of a dystopian society.',
          ),
        ];
      case 'Movies':
        return [
          Recommendation(
            title: 'Up',
            imageUrl: 'lib/images/up.png',
            description:
                'Up (2009) is an animated adventure that follows an elderly widower and a young boy as they embark on a heartwarming journey in a house suspended by balloons to fulfill the dream of the mans late wife.',
          ),
          Recommendation(
            title: 'Life is Beautiful',
            imageUrl: 'lib/images/lib.png',
            description:
                'An Italian film about a father\'s attempt to shelter his son from the horrors of a concentration camp.',
          ),
          Recommendation(
            title: 'Requiem for a Dream',
            imageUrl: 'lib/images/rfad.png',
            description:
                ' A visceral and intense film portraying the destructive impact of addiction on individuals and their relationships.',
          ),
        ];
      case 'Songs':
        return [
          Recommendation(
            title: 'Someone Like You - Adele',
            imageUrl: 'lib/images/sly.png',
            description: 'A soulful song about heartbreak and lost love.',
          ),
          Recommendation(
            title: 'Tears in Heaven - Eric Clapton',
            imageUrl: 'lib/images/tih.png',
            description: 'A poignant song expressing grief and loss.',
          ),
          Recommendation(
            title: 'Hallelujah - Jeff Buckley',
            imageUrl: 'lib/images/jeff.png',
            description:
                'A soulful and melancholic rendition of Leonard Cohens classic, expressing the complexities of love and spirituality.',
          ),
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
            imageUrl: 'lib/images/tgwtdt.png',
            description:
                'A gripping mystery novel with a cool and resourceful protagonist.',
          ),
          Recommendation(
            title: 'Ready Player One',
            imageUrl: 'lib/images/rp1.png',
            description:
                'A science fiction adventure set in a virtual reality world.',
          ),
          Recommendation(
            title: 'The Big Sleep',
            imageUrl: 'lib/images/tbs.png',
            description:
                'Raymond Chandlers classic noir novel featuring the cool and enigmatic private detective Philip Marlowe.',
          ),
        ];
      case 'Movies':
        return [
          Recommendation(
            title: 'The Matrix',
            imageUrl: 'lib/images/matrix.png',
            description:
                'A sci-fi classic that explores the concept of reality and virtual worlds.',
          ),
          Recommendation(
            title: 'Drive',
            imageUrl: 'lib/images/drive.png',
            description:
                'A stylish and cool film about a stuntman who moonlights as a getaway driver.',
          ),
          Recommendation(
            title: 'Heat',
            imageUrl: 'lib/images/heat.png',
            description:
                'A crime thriller with a cool ensemble cast, exploring the lives of criminals and detectives on opposite sides of the law.',
          ),
        ];
      case 'Songs':
        return [
          Recommendation(
            title: 'Smooth Operator - Sade',
            imageUrl: 'lib/images/so.png',
            description: 'A smooth and cool jazz-pop song.',
          ),
          Recommendation(
            title: 'Hit The Road Jack - Ray Charles',
            imageUrl: 'lib/images/htrj.png',
            description:
                'A laid-back and cool song by the legendary Ray Charles.',
          ),
          Recommendation(
            title: 'Royals - Lorde',
            imageUrl: 'lib/images/royals.png',
            description:
                'A minimalist and stylish pop anthem with Lordes cool and distinctive vocals.',
          ),
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
            imageUrl: 'lib/images/fc.png',
            description:
                'A novel that explores the disillusionment and anger of modern life.',
          ),
          Recommendation(
            title: 'The Girl on the Train',
            imageUrl: 'lib/images/tgott.png',
            description:
                'A psychological thriller with themes of betrayal and anger.',
          ),
          Recommendation(
            title: 'One Flew Over the Cuckoos Nest',
            imageUrl: 'lib/images/ofotcn.png',
            description:
                'A classic novel that critiques societal norms through the experiences of patients in a mental institution.',
          ),
        ];
      case 'Movies':
        return [
          Recommendation(
            title: 'American History X',
            imageUrl: 'lib/images/ahx.png',
            description:
                'A film that delves into the roots of racism and anger in America.',
          ),
          Recommendation(
            title: 'Taxi Driver',
            imageUrl: 'lib/images/td.png',
            description:
                'A classic film depicting the descent into anger and violence.',
          ),
          Recommendation(
            title: 'Se7en',
            imageUrl: 'lib/images/seven.png',
            description:
                'A gritty and psychological crime thriller that explores the darkest aspects of human nature.',
          ),
        ];
      case 'Songs':
        return [
          Recommendation(
            title: 'Killing in the Name - Rage Against the Machine',
            imageUrl: 'lib/images/kitn.png',
            description:
                'A powerful protest song expressing anger against authority.',
          ),
          Recommendation(
            title: 'Break Stuff - Limp Bizkit',
            imageUrl: 'lib/images/bs.png',
            description: 'An intense song reflecting frustration and anger.',
          ),
          Recommendation(
            title: 'Down with the Sickness - Disturbed',
            imageUrl: 'lib/images/dwts.png',
            description:
                'An intense and aggressive metal song expressing frustration and disillusionment.',
          ),
        ];
      default:
        return [];
    }
  }
}

class JournalPage extends StatefulWidget {
  final List<String> journalEntries;

  const JournalPage({Key? key, required this.journalEntries}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  TextEditingController _notesController = TextEditingController();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Page'),
        backgroundColor: Color.fromRGBO(139, 76, 252, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Journal Entries',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.journalEntries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          widget.journalEntries[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_notesController.text.isNotEmpty) {
                  setState(() {
                    widget.journalEntries.add(_notesController.text);
                    _notesController.clear();
                    _pageController.animateToPage(
                      widget.journalEntries.length - 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                }
              },
              child: Text('Save Entry'),
             
            ),
          ],
        ),
      ),
    );
  }
}


 
class RecommendationCard extends StatelessWidget {
  final Recommendation recommendation;

  const RecommendationCard({Key? key, required this.recommendation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showRecommendationDetails(context, recommendation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        height: 300, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(recommendation.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recommendation.title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showRecommendationDetails(
      BuildContext context, Recommendation recommendation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(recommendation.title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200, // Adjust the height as needed
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(recommendation.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
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
  final String imageUrl;
  final String description;

  Recommendation({
    required this.title,
    required this.imageUrl,
    required this.description,
  });
}
