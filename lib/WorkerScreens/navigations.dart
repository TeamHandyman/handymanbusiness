import 'package:flutter/material.dart';
import 'package:handymanbusiness/WorkerScreens/home.dart';
import 'package:handymanbusiness/WorkerScreens/joblist.dart';
import 'package:handymanbusiness/WorkerScreens/notifications.dart';
import 'package:handymanbusiness/WorkerScreens/post.dart';
import 'package:handymanbusiness/WorkerScreens/profile.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = '/navigationscreen';

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    JoblistScreen(),
    PostScreen(),
    NotificationScreen(),
    const ProfileScreen(),
  ];
  int _selectedPageIndex = 0;
  final controller = PageController(initialPage: 0);
  int currentPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectPage,
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.home,
                // color: Colors.white,
                size: 22,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                size: 22,
                color: Theme.of(context).buttonColor,
              )),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.schedule,
              color: Colors.white,
              size: 25,
            ),
            label: 'Schedule',
            activeIcon: Icon(
              Icons.schedule,
              color: Theme.of(context).buttonColor,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
                size: 22,
              ),
              label: 'Post',
              activeIcon: Icon(
                Icons.add_box_rounded,
                color: Theme.of(context).buttonColor,
                size: 22,
              )),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 22,
              ),
              label: 'Notification',
              activeIcon: Icon(
                Icons.notifications,
                color: Theme.of(context).buttonColor,
                size: 22,
              )),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 22,
              ),
              label: 'Profile',
              activeIcon: Icon(
                Icons.person,
                color: Theme.of(context).buttonColor,
                size: 22,
              )),
        ],
      ),
    );
  }
}
