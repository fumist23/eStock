import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/map_page.dart';
import 'package:flutter_application_2/view/user_page.dart';

import '../view/home_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: HomePage(),
              ),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: MapPage(),
              ),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: UserPage(),
              ),
            );
        }
        return Container();
      },
    );
  }
}
