import 'package:flutter/material.dart';
import 'package:flutter_application_1/favorite.dart';
import 'package:flutter_application_1/home/home_screen.dart';
import 'package:flutter_application_1/popular.dart';
import 'package:flutter_application_1/setting.dart';

import 'color.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  List<Map<String, dynamic>> listBottom = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Favorite", "icon": Icons.favorite},
    {"name": "Popular", "icon": Icons.soap},
    {"name": "Setting", "icon": Icons.settings}
  ];
  String _page = "Home";
  int currentIndex = 0;

  Widget _renderPage(String page) {
    switch (page) {
      case "Home":
        return HomeScreen();
      case "Favorite":
        return FavoriteScreen();
      case "Popular":
        return PopularScreen();
      case "Setting":
        return SettingScreen();

      default:
        return HomeScreen();
    }
  }

  onBottomNavigationTap(int index) {
    setState(() {
      currentIndex = index;
      switch (currentIndex) {
        case 0:
          _page = "Home";
          return;
        case 1:
          _page = "Favorite";
          return;
        case 2:
          _page = "Popular";
          return;
        case 3:
          _page = "Setting";
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(listBottom[currentIndex]["name"]),
      // ),
      body: _renderPage(_page),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: DefaultColor.secondaryColor,
        selectedItemColor: DefaultColor.primaryColor,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          for (int i = 0; i < listBottom.length; i++)
            BottomNavigationBarItem(
                icon: Icon(
                  listBottom[i]['icon'],
                ),
                label: listBottom[i]['name']),
        ],
        onTap: (index) {
          onBottomNavigationTap(index);
        },
      ),
    );
  }
}
