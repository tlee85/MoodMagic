import 'package:flutter/material.dart';
import 'dart:math';

class SocialPage extends StatelessWidget {
  const SocialPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) =>
              buildSocialListItem(context, index),
        ),
      ),
    );
  }

  Widget buildSocialListItem(BuildContext context, int index) {
    String username = 'User $index';
    IconData randomIcon = getRandomIcon();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageThreadPage(
              username: username,
              profileIcon: randomIcon,
            ),
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey[100],
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: Icon(
                randomIcon,
                size: 30,
                color: Colors.blueGrey[700],
              ),
            ),

            // User Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap to chat',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getRandomIcon() {
    List<IconData> icons = [
      Icons.face,
      Icons.pets,
      Icons.star,
      Icons.favorite,
      Icons.accessibility,
      Icons.alarm,
      Icons.beach_access,
      Icons.cake,
      Icons.directions_run,
      Icons.local_cafe,
      Icons.music_note,
      Icons.palette,
      Icons.shopping_cart,
      Icons.train,
    ];

    final Random random = Random();
    int randomIndex = random.nextInt(icons.length);
    return icons[randomIndex];
  }
}

class MessageThreadPage extends StatefulWidget {
  final String username;
  final IconData profileIcon;

  const MessageThreadPage({
    Key? key,
    required this.username,
    required this.profileIcon,
  }) : super(key: key);

  @override
  _MessageThreadPageState createState() => _MessageThreadPageState();
}

class _MessageThreadPageState extends State<MessageThreadPage> {
  List<String> messages = [];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Profile Picture in the App Bar
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey[100],
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: Icon(
                widget.profileIcon,
                size: 20,
                color: Colors.blueGrey[700],
              ),
            ),

            // Username in the App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(widget.username),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => buildMessageBubble(messages[index]),
              ),
            ),
          ),

          // Message Input and Send Button
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onChanged: (text) {
                      // Add your logic to update the message text
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add your logic to send the message
                    sendMessage(_messageController.text);
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageBubble(String message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(message),
    );
  }

  void sendMessage(String message) {
    setState(() {
      messages.insert(0, message);
    });
  }
}
