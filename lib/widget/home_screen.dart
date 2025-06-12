import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/widget/add_task.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();

    _loadUsername();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        width: 168,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext conte) {
                  return AddTask();
                },
              ),
            );
          },
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Color(0xFFFFFFCF),
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
        ),
      ),
      backgroundColor: Color(0xFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundImage: AssetImage(
                  //     'assets/images/welcom.svg',
                  //   ),
                  // ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening , $username',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFCFC),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Yuhuu ,Your work Is ,',
                style: TextStyle(
                  color: Color(0xFFFFFFCF),
                  fontSize: 32,
                ),
              ),
              Row(
                children: [
                  Text(
                    'almost done ! ',
                    style: TextStyle(
                      color: Color(0xFFFFFFCF),
                      fontSize: 32,
                    ),
                  ),
                  SvgPicture.asset('assets/images/wave_hand.svg')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
