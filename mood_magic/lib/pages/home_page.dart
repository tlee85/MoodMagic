import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              ]),

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
              ]),

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
              ]),

              SizedBox(height: 20),

              // Mood Tracker
              buildSectionTitle('Mood Tracker'),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                // Add mood tracker UI here
                child: Text('Track your mood over time.'),
              ),

              SizedBox(height: 20),

              // Affirmations
              buildSectionTitle('Affirmations'),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                // Add affirmations UI here
                child: Text('Positive affirmations for you.'),
              ),

              SizedBox(height: 20),

              // Mindfulness Exercises
              buildSectionTitle('Mindfulness Exercises'),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                // Add mindfulness exercises UI here
                child: Text('Quick exercises to relax and de-stress.'),
              ),

              SizedBox(height: 20),

              // Meditation Timer
              ElevatedButton(
                onPressed: () {
                  // Show a pop-up to set the meditation timer
                  showMeditationTimerDialog(context);
                },
                child: Text('Meditate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRecommendationSection(String category, List<String> recommendations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Displaying recommendations using cards
              for (String recommendation in recommendations)
                RecommendationCard(recommendation: recommendation),

              // Dropdown arrow
              recommendations.length > 5
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 40,
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        items: [
                          for (int i = 5; i < recommendations.length; i++)
                            DropdownMenuItem(
                              value: recommendations[i],
                              child: Text(
                                recommendations[i],
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

  Widget buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.purpleAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  void showMeditationTimerDialog(BuildContext context) {
    int meditationDuration = 5; // Default duration in minutes

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Meditation Timer'),
          content: Column(
            children: [
              Text('Choose the meditation duration:'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int duration in [5, 10, 15])
                    ElevatedButton(
                      onPressed: () {
                        // Set the selected duration
                        meditationDuration = duration;
                        Navigator.pop(context);
                      },
                      child: Text('$duration min'),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((value) {
      // After the dialog is closed, start the meditation countdown
      startMeditationTimer(context, Duration(minutes: meditationDuration));
    });
  }

  void startMeditationTimer(BuildContext context, Duration duration) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Meditation Timer'),
          content: Column(
            children: [
              Text('Take a deep breath and relax.'),
              SizedBox(height: 20),
              CountdownTimer(duration: duration),
            ],
          ),
        );
      },
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String recommendation;

  const RecommendationCard({Key? key, required this.recommendation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final Duration duration;

  const CountdownTimer({Key? key, required this.duration}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer timer;
  late int secondsRemaining;

  @override
  void initState() {
    super.initState();
    secondsRemaining = widget.duration.inSeconds;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;

    return Text(
      '$minutes:${seconds < 10 ? '0' : ''}$seconds',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining -= 1;
        } else {
          timer.cancel();
          showCongratulationsDialog(context);
        }
      });
    });
  }

  void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You completed the meditation session.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
