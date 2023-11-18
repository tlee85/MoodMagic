import 'package:flutter/material.dart';
import 'dart:math';

class SocialPage extends StatelessWidget {
  const SocialPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey[100],
              ),
              child: Icon(
                randomIcon,
                size: 40,
                color: Colors.blueGrey[700],
              ),
            ),

            // User Info
            Expanded(
              child: Stack(
                children: [
                  // Overlay: Username
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        username,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(messages[index]),
                // You can also show the sender's name or other details here
              ),
            ),
          ),

          // Message Input and Send Button
          Padding(
            padding: const EdgeInsets.all(8.0),
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

  void sendMessage(String message) {
    setState(() {
      messages.add(message);
    });
  }
}
