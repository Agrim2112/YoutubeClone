import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubeclone/screens/home/screens/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_tab.dart';

enum TabItem { home, add, profile }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, Widget> _screens = {
    TabItem.home: const HomeTabScreen(),
    TabItem.profile: const ProfileScreen(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == TabItem.add) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Upload'),
          content: Text('Upload action goes here'),
        ),
      );
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:_screens[_currentTab],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 12.0,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600
          ),
          unselectedFontSize: 12.0,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  (_currentTab == TabItem.home) ? CupertinoIcons.house_fill : CupertinoIcons.house,
                ),
              ),
              label: "Home"
            ),
            const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(CupertinoIcons.add),
                ),
                label: "Upload",
            ),
            const BottomNavigationBarItem(
                icon:Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(CupertinoIcons.profile_circled),
                ),
                label: "Profile")
          ],
        currentIndex: _currentTab.index,
        onTap: (index) => _selectTab(TabItem.values[index]),
        ),
      ),
    );
  }
}
