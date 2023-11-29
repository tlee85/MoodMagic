import 'package:flutter/material.dart';
import 'components/my_bottom_nav_bar.dart';
import 'components/my_drawer.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/social_page.dart';
import 'pages/calendar_page.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const CalendarPage(),
    const ProfilePage(),
    const SocialPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var image = AssetImage('lib/images/logos.png');

    return Scaffold(
      backgroundColor: Color.fromRGBO(139, 76, 252, 50),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Image(image: image, height: 118, width: 180), // Adjust the height and width as needed
      ),
      drawer: const MyDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
