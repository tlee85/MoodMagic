import 'package:flutter/material.dart';
import 'dart:math';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _currentUsername = 'JohnDoe'; // Initial username
  IconData _currentProfilePicture = Icons.account_circle; // Initial profile picture

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Account'),
              Tab(text: 'Help'),
              Tab(text: 'Settings'),
              Tab(text: 'Membership'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Account Tab
            buildAccountTabContent(),

            // Help Tab
            buildHelpTabContent(),

            // Settings Tab
            buildSettingsTabContent(),

            // Membership Tab
            buildMembershipTabContent(),
          ],
        ),
      ),
    );
  }

  Widget buildAccountTabContent() {
    return ListView(
      children: [
        // Profile Picture Section
        Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: GestureDetector(
              onTap: () {
                // Open the profile picture selection dialog
                showProfilePictureSelectionDialog(context);
              },
              child: Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Icon(
                  _currentProfilePicture,
                  size: 120, // Adjust the size as needed
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
        ),

        // Change Profile Picture Option
        ListTile(
          title: Text('Change Profile Picture'),
          onTap: () {
            // Open the profile picture selection dialog
            showProfilePictureSelectionDialog(context);
          },
        ),

        // Change Username Option
        ListTile(
          title: Text('Change Username'),
          onTap: () {
            // Open the username change dialog
            showChangeUsernameDialog(context);
          },
        ),

        // Displayed Username
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              _currentUsername,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),

        // Grid of photos or items
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => Container(
            height: 200,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[200],
            ),
            child: GestureDetector(
              onTap: () {
                // Update the main profile picture with the selected one
                setState(() {
                  _currentProfilePicture = getRandomIcon();
                });
              },
              child: Icon(
                getRandomIcon(),
                size: 80,
                color: Colors.grey[500],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showProfilePictureSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Profile Picture'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Update the main profile picture with the selected one
                    setState(() {
                      _currentProfilePicture = getRandomIcon();
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      getRandomIcon(),
                      size: 60,
                      color: Colors.grey[500],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  IconData getRandomIcon() {
    final List<IconData> icons = [
      Icons.face,
      Icons.pets,
      Icons.accessibility,
      Icons.star,
      Icons.favorite,
      Icons.cake,
      Icons.school,
      Icons.work,
      Icons.food_bank,
    ];
    final Random random = Random();
    return icons[random.nextInt(icons.length)];
  }

  void showChangeUsernameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newUsername = _currentUsername;
        return AlertDialog(
          title: Text('Change Username'),
          content: TextField(
            decoration: InputDecoration(labelText: 'New Username'),
            onChanged: (value) {
              newUsername = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the displayed username
                setState(() {
                  _currentUsername = newUsername;
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget buildHelpTabContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Welcome to Mood Magic\'s Help Section!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'If you or someone you know is struggling with mental health, remember that help is available. Here are some resources and tips:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        _buildHelpItem(
          title: 'National Suicide Prevention Lifeline',
          description:
              'Call 1-800-273-TALK (1-800-273-8255) if you or someone you know is in crisis.',
        ),
        _buildHelpItem(
          title: 'Crisis Text Line',
          description:
              'Text "HELLO" to 741741 to connect with a trained crisis counselor.',
        ),
        _buildHelpItem(
          title: 'Therapy and Counseling',
          description:
              'Consider seeking professional help from a therapist or counselor. Mood Magic can help you find local resources.',
        ),
        _buildHelpItem(
          title: 'Self-Help Resources',
          description:
              'Explore self-help books, apps, and online resources that focus on mental health and well-being.',
        ),
        _buildHelpItem(
          title: 'Mood Tracking',
          description:
              'Use Mood Magic\'s mood tracking feature to monitor and understand your emotions over time.',
        ),
        _buildHelpItem(
          title: 'Diary Feature',
          description:
              'Take advantage of the diary feature to jot down your thoughts and feelings. It can be a helpful way to express yourself and track your mental health journey.',
        ),
      ],
    );
  }

  Widget buildSettingsTabContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ListTile(
          title: Text('Notifications'),
          subtitle: Text('Receive alerts and updates'),
          trailing: Switch(
            value: true, // Placeholder value, you should use a variable to control the state
            onChanged: (value) {
              // Add logic to handle notification setting change
              print('Notifications switched: $value');
            },
          ),
        ),
        ListTile(
          title: Text('Dark Mode'),
          subtitle: Text('Enable or disable dark mode'),
          trailing: Switch(
            value: true, // Placeholder value, you should use a variable to control the state
            onChanged: (value) {
              // Add logic to handle dark mode setting change
              print('Dark Mode switched: $value');
            },
          ),
        ),
        ListTile(
          title: Text('Language'),
          subtitle: Text('Select your preferred language'),
          onTap: () {
            // Add logic to open language selection
            print('Language tapped');
          },
        ),
      ],
    );
  }

  Widget buildMembershipTabContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Unlock Magic+ Membership',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Get unlimited recommendations for only \$5 a month!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Show a confirmation pop-up
              showPurchaseConfirmation(context);
            },
            child: Text('Upgrade to Magic+'),
          ),
        ],
      ),
    );
  }
  void showPurchaseConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Purchase'),
          content: Text('Are you sure you want to upgrade to Magic+ for \$5 a month?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform the purchase logic here
                // You can integrate with in-app purchase libraries or handle it according to your requirements
                // For simplicity, print a message for now
                print('Purchase confirmed');
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHelpItem({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
