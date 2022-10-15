import 'package:flutter/material.dart';

import './upcoming_contests.dart';
import './notif_contests.dart';

//SCREEN INFO
//This will be home page of the app
//Bottom Navigation bar will be used to switch between pages
class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //List of widgets to be rendered on tabs
  final List<Widget> _pages = [
    const UpcomingContests(),
    const NotifContestScreen(),
  ];

  //The index of the current render tab
  int _selectedPageIndex = 0;

  //Handler to change/switch tabs
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Upcoming'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active), label: 'Notifications'),
        ],
      ),
      body: _pages[_selectedPageIndex],
    );
  }
}
