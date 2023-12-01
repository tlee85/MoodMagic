import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences _prefs;

  String _currentEmail = 'john.doe@example.com';
  String _currentUsername = 'JohnDoe';
  String _currentPassword = 'password';
  String _currentProfilePicture = 'lib/images/racc.png';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentUsername = _prefs.getString('username') ?? 'JohnDoe';
      _currentProfilePicture =
          _prefs.getString('profilePicture') ?? 'lib/images/nash.png';
      _currentEmail = _prefs.getString('email') ?? 'john.doe@example.com';
    });
  }

  Future<void> _saveUserData() async {
    await _prefs.setString('username', _currentUsername);
    await _prefs.setString('profilePicture', _currentProfilePicture);
    await _prefs.setString('email', _currentEmail);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color.fromRGBO(139, 76, 252, 50),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Account'),
              Tab(text: 'Help'),
              Tab(text: 'Settings'),
              Tab(text: 'Membership'),
            ],
            indicatorColor: Colors.white,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile Picture and Name Section
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
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
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(_currentProfilePicture),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      _currentUsername,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Change Profile Picture Option
          _buildOptionButton(
            title: 'Change Profile Picture',
            onPressed: () {
              // Open the profile picture selection dialog
              showProfilePictureSelectionDialog(context);
            },
          ),

          // Change Username Option
          _buildOptionButton(
            title: 'Change Username',
            onPressed: () {
              // Open the username change dialog
              showChangeUsernameDialog(context);
            },
          ),

          // Change Email Option
          _buildOptionButton(
            title: 'Change Email',
            onPressed: () {
              showChangeEmailDialog(context);
            },
          ),

          _buildOptionButton(
            title: 'Change Password',
            onPressed: () {
              showChangePasswordDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(
      {required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        elevation: 5,
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ),
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
              itemCount: 7,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _currentProfilePicture = getProfilePictureForIndex(index);
                    });
                    _saveUserData();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage(getProfilePictureForIndex(index)),
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

  String getProfilePictureForIndex(int index) {
    final List<String> profilePictures = [
      'lib/images/nash.png',
      'lib/images/racc.png',
      'lib/images/bint.png',
      'lib/images/beetle.png',
      'lib/images/treeball.png',
      'lib/images/natheart.png',
      'lib/images/logos.png',
    ];

    if (index < profilePictures.length) {
      return profilePictures[index];
    }

    return 'lib/images/nash.png'; // Return a default image in case of an out-of-bounds index
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
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentUsername = newUsername;
                });
                _saveUserData();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showChangeEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEmail = _currentEmail;
        return AlertDialog(
          title: Text('Change Email'),
          content: TextField(
            decoration: InputDecoration(labelText: 'New Email'),
            onChanged: (value) {
              newEmail = value;
            },
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
                setState(() {
                  _currentEmail = newEmail;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newPassword = _currentPassword;
        return AlertDialog(
          title: Text('Change Password'),
          content: TextField(
            decoration: InputDecoration(labelText: 'New Password'),
            onChanged: (value) {
              newPassword = value;
            },
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
                setState(() {
                  _currentPassword = newPassword;
                });
                Navigator.pop(context);
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
            value: true,
            onChanged: (value) {
              print('Notifications switched: $value');
            },
          ),
        ),
        ListTile(
          title: Text('Dark Mode'),
          subtitle: Text('Enable or disable dark mode'),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              print('Dark Mode switched: $value');
            },
          ),
        ),
        ListTile(
          title: Text('Language'),
          subtitle: Text('Select your preferred language'),
          onTap: () {
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
          content: Text(
              'Are you sure you want to upgrade to Magic+ for \$5 a month?'),
          actions: [
            TextButton(
              onPressed: () {
                print('Purchase confirmed');
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
