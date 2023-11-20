import 'package:flutter/material.dart';

/*

A B O U T P A G E

This is the AboutPage. This is usually a static page that displays lots of text
describing what your app/business does.

This is also a great place to give the user a link or email that they can use 
to give any feedback about the app.

*/

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(139, 76, 252, 50),
        elevation: 0,
        title: Text(
          'A B O U T',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const
        Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('Mood Magic was designed for young adults who struggle dealing with stress, to manage their mental health with recommendations and user-to-user communication chosen by our unique algorithms.'),
        )
      ),
      
    );
  }
}
