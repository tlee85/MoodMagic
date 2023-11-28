import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(207, 204, 251, 1),
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
    AssetImage sequentialImage = getSequentialImage(index);

    // List of possible text choices
    List<String> chatTexts = [
      'Yo you should check out this movie',
      'Feeling hella sad today',
      'gadjbeaifyieabifyeaif',
      'Whoah Nash should totally give us an A+',
      'You heard about Nash giving us an A++++?',
      'I cannot believe this looks so good for investors amirite',
      'hahahahahahahahah',
      'wowzers',
    ];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageThreadPage(
              username: username,
              profileImage: sequentialImage,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(207, 204, 251, 1),
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
                  child: CircleAvatar(
                    backgroundImage: sequentialImage,
                    radius: 30,
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
                          chatTexts[index % chatTexts.length],
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
          Divider(
            color: Colors.grey,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  String getRandomUsername() {
    List<String> usernames = [
      'Alice',
      'BobbyBoy',
      'HannahBanana',
      'Davvvvviid',
      'Eva',
      'Frankfurther',
      'Grace272',
      'BondJamesBond',
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
            child: Column(
              children: <Widget>[
                FriendsBox(index: 0),
                FriendsBox(index: 2),
                FriendsBox(index: 1),
                FriendsBox(index: 1),
                FriendsBox(index: 3),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
                FriendsBox(index: 0),
              ],
            ),
          ),
        ));
  }
}

AssetImage getSequentialImage(int index) {
  List<String> imagePaths = [
    'lib/images/nash.png',
    'lib/images/astro.png',
    'lib/images/mike.png',
    'lib/images/racc.png',
    'lib/images/bint.png',
    'lib/images/beetle.png',
    'lib/images/treeball.png',
    'lib/images/natheart.png',
    // Add more image paths as needed
  ];

  // Use the index to get the image path sequentially
  return AssetImage(imagePaths[index % imagePaths.length]);
}

class FriendsBox extends StatelessWidget {
  final int index;

  FriendsBox({required this.index});

  @override
  Widget build(BuildContext context) {
    AssetImage sequentialImage = getSequentialImage(index);

    return Container(
      height: 100,
      width: 400,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.grey),
        ),
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
                child: CircleAvatar(
                  backgroundImage: sequentialImage,
                  radius: 30,
                ),
              ),
            ),
            Text(getRandomUsername()),
          ],
        ),
      ),
    );
  }

  String getRandomUsername() {
    List<String> usernames = [
      'Alice',
      'BobbyBoy',
      'Charlie',
      'Davvvvvid',
      'Eva',
      'Frank',
      'Grace272',
      'Hank',
      'Ivy',
      'BondJamesBond',
      'cottonEyeJoe',
      'Jakethesnakedog',
      'Jillli',
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
}

class MessageThreadPage extends StatefulWidget {
  final String username;
  final AssetImage profileImage;

  const MessageThreadPage({
    Key? key,
    required this.username,
    required this.profileImage,
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
    List<String> savedMessages =
        prefs.getStringList('messages_${widget.username}') ?? [];
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
              child: CircleAvatar(
                backgroundImage:
                    widget.profileImage, // Use widget.profileImage here
                radius: 20,
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
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
              child: CircleAvatar(
                backgroundImage: widget.profileImage,
                radius: 15,
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
