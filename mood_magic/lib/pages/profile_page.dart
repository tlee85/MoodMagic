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

  String _currentEmail = 'john.doe@example.com'; // Initial email
  String _currentUsername = 'JohnDoe'; // Initial username
  String _currentPassword = 'password';// Initial password
  IconData _currentProfilePicture = Icons.account_circle; // Initial profile picture

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
          IconData(_prefs.getInt('profilePicture') ?? Icons.account_circle.codePoint, fontFamily: 'MaterialIcons');
      _currentEmail = _prefs.getString('email') ?? 'john.doe@example.com';
    });
  }

  Future<void> _saveUserData() async {
    await _prefs.setString('username', _currentUsername);
    await _prefs.setInt('profilePicture', _currentProfilePicture.codePoint);
    await _prefs.setString('email', _currentEmail);
  }

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
                  child: Icon(
                    _currentProfilePicture,
                    size: 120,
                    color: Colors.grey[500],
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
                  // Additional information or buttons can be added here
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
            // Open the email change dialog
            showChangeEmailDialog(context);
          },
        ),

        // Change Password Option
        _buildOptionButton(
          title: 'Change Password',
          onPressed: () {
            // Open the password change dialog
            showChangePasswordDialog(context);
          },
        ),
      ],
    ),
  );
}


  Widget _buildOptionButton({required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        elevation: 5, // Add a drop shadow effect
        padding: EdgeInsets.zero, // Set padding to zero
      ),
      child: Container(
        padding: EdgeInsets.all(16), // Add padding inside the button content
        alignment: Alignment.centerLeft, // Align text to the left
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left, // Align text to the left
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
              itemCount: 9,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Update the main profile picture with the selected one
                    setState(() {
                      _currentProfilePicture = getRandomIcon();
                    });
                    _saveUserData(); // Save the updated user data
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
              _saveUserData(); // Save the updated user data
              Navigator.pop(context); // Close the dialog
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
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the displayed email
                setState(() {
                  _currentEmail = newEmail;
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
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the displayed email
                setState(() {
                  _currentPassword = newPassword;
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
