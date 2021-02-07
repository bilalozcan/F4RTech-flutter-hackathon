import 'package:education/ui/home_page/share_student.dart';
import 'package:education/ui/leaderboard/leader_board.dart';
import 'package:education/ui/post_page/post_page.dart';
import 'package:education/ui/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'navigationbar_model.dart';
import '../leaderboard/leader_board.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  TabController tabController;

  @override
  void initState() {
    _pageController.addListener(() {
      var currentIndex = _pageController.page.round();
      if (currentIndex != bottomNavBarSelectedIndex) {
        bottomNavBarSelectedIndex = currentIndex;
      }
      setState(() {});
    });
    super.initState();
  }

  void handleIndexChanged(int value) {
    if (value != bottomNavBarSelectedIndex) {
      setState(() {
        bottomNavBarSelectedIndex = value;
      });
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    LeaderBoard(),
    PostPage(),
    ProfilePage(),
    ShareContent()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bottomNavBarSelectedIndex,
        onTap: handleIndexChanged,
        items: [
          /// Liderlik
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.trophy),
            title: Text('Liderlik'),
            selectedColor: Colors.purple,
          ),

          /// Anasayfa
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text('Anasayfa'),
            selectedColor: Colors.pink,
          ),

          /// Profil
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.userAlt, size: 20),
            title: Text('Profil'),
            selectedColor: Colors.orange,
          ),

          // More
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.ellipsisH),
            title: Text('More'),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      body: _widgetOptions.elementAt(bottomNavBarSelectedIndex),
    );
  }
}
