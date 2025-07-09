import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String username;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString('username') ?? '';
      isLoading = false;
    });
  }

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'My Profile',
                      style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/profile.png',
                              ),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xFF282828),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Color(0xFFFFFCFC),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFFFFCFC),
                          ),
                        ),

                        Text(
                          'One task at a time. One step closer.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Profile Info',

                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'User Details',
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
                    ),
                    leading: SvgPicture.asset(
                      'assets/images/leading_element.svg',
                    ),
                    trailing: SvgPicture.asset(
                      'assets/images/arrow_element.svg',
                    ),
                  ),

                  SizedBox(height: 18),
                  Divider(color: Color(0xFF6E6E6E), thickness: 1),
                  SizedBox(height: 13),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
                    ),
                    leading: SvgPicture.asset('assets/images/dark.svg'),
                    trailing: Switch(
                      value: isHighPriority,
                      onChanged: (value) {
                        setState(() {
                          isHighPriority = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(color: Color(0xFF6E6E6E)),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Log Out',
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
                    ),
                    leading: SvgPicture.asset('assets/images/logout.svg'),
                    trailing: SvgPicture.asset(
                      'assets/images/arrow_element.svg',
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
