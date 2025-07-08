import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/screens/home_screen.dart';
import 'package:flutter_mastering_course/screens/profile_screen.dart' show ProfileScreen;
import 'package:flutter_mastering_course/screens/task_completed_screen.dart';
import 'package:flutter_mastering_course/screens/todo_screen.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TodoScreen(),
    TaskCompletedScreen(),
    ProfileScreen(),
  ];

  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentScreen,
        backgroundColor: Color(0xFF181818),
        unselectedItemColor: Color(0xFFC6C6C6),
        selectedItemColor: Color(0xFF15B86C),
        type: BottomNavigationBarType.fixed,
        onTap: (int? index) {
          setState(() {
            _currentScreen = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              colorFilter: ColorFilter.mode(
                _currentScreen == 0 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/todo.svg",
              colorFilter: ColorFilter.mode(
                _currentScreen == 1 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/task_complete.svg",
              colorFilter: ColorFilter.mode(
                _currentScreen == 2 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/profile.svg",
              colorFilter: ColorFilter.mode(
                _currentScreen == 3 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'profile',
          ),
        ],
      ),
      body: _screens[_currentScreen],
    );
  }
}
