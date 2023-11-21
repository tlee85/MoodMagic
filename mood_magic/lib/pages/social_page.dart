import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

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
          itemBuilder: (context, index) => buildSocialListItem(context, index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendsPage(),
            ),
          );
        },
        child: Icon(Icons.group),
      ),
    );
  }

  Widget buildSocialListItem(BuildContext context, int index) {
    String username = getRandomUsername();
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

  String getRandomUsername() {
    List<String> usernames = [
      'Alice',
      'Bob',
      'Charlie',
      'David',
      'Eva',
      'Frank',
      'Grace',
      'Hank',
      'Ivy',
      'Jack',
    ];

    final Random random = Random();
    int randomIndex = random.nextInt(usernames.length);
    return usernames[randomIndex];
  }
}

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends (15)'),
        backgroundColor: Color.fromRGBO(139, 76, 252, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            FriendsBox(), FriendsBox(), FriendsBox(), FriendsBox(), FriendsBox(),
            FriendsBox(), FriendsBox(), FriendsBox(), FriendsBox(), FriendsBox(),
            FriendsBox(), FriendsBox(), FriendsBox(), FriendsBox(), FriendsBox(),
            ],
          ),
        ),
      )
    );
  }
}

class FriendsBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 400,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.grey),
        )
      ),
      child: Scaffold(
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey[100],
                  border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                  ),
                ),
                child: Icon(
                  getRandomIcon(),
                  size: 30,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
            Text(getRandomUsername()),
          ],
        )
      )
    );
  }

  String getRandomUsername() {
    List<String> usernames = [
      'Alice',
      'Bob',
      'Charlie',
      'David',
      'Eva',
      'Frank',
      'Grace',
      'Hank',
      'Ivy',
      'Jack',
      'Joe',
      'Jake',
      'Jill',
      'Chris',
      'Martin',
      'Yu',
      'Lee',
      'Cong',
      'Jenny',
      'Cook',
      'James',
      'Fabian',
      'Bill',
      'Josh',
      'Mac',
    ];

    final Random random = Random();
    int randomIndex = random.nextInt(usernames.length);
    return usernames[randomIndex];
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
  late SharedPreferences prefs;

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadMessages();
  }

  Future<void> loadMessages() async {
    List<String> savedMessages = prefs.getStringList('messages_${widget.username}') ?? [];
    setState(() {
      messages = savedMessages;
    });
  }

  Future<void> saveMessages() async {
    await prefs.setStringList('messages_${widget.username}', messages);
  }

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
                itemBuilder: (context, index) => buildMessageBubble(index),
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

  Widget buildMessageBubble(int index) {
    String message = messages[index];
    bool isMe = message.startsWith('Me:');

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
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            // Profile Picture for received messages
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 8),
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
                size: 15,
                color: Colors.blueGrey[700],
              ),
            ),
          Text(message),
        ],
      ),
    );
  }

  void sendMessage(String message) {
    setState(() {
      messages.insert(0, 'Me: $message');
      // Generate and add a random response
      String randomResponse = generateRandomResponse();
      messages.insert(0, '${widget.username}: $randomResponse');
      saveMessages();
    });
  }

  String generateRandomResponse() {
    List<String> responses = [
      'Hello!',
      'How are you?',
      'Nice to meet you!',
      'What\'s up?',
      'Tell me more!',
      'I like that!',
      'Interesting...',
    ];

    final Random random = Random();
    int randomIndex = random.nextInt(responses.length);
    return responses[randomIndex];
  }
}
