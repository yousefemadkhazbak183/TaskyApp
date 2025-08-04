import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';
import 'package:flutter_mastering_course/screens/user_details_screen.dart';
import 'package:flutter_mastering_course/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  String? motivationQuote;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    setState(() {
      username = PreferencesManager().getString('username') ?? '';
      motivationQuote = PreferencesManager().getString('motivation_quote');
      isLoading = false;
    });
  }

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
                      style: Theme.of(context).textTheme.bodyMedium,
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

                            // Camera for change image
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ThemeController.isDark()
                                      ? Color(0xFF282828)
                                      : Color(0xFFFFFFFF),
                                ),
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          username,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        Text(
                          motivationQuote ??
                              'One task at a time. One step closer.',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Profile Info',

                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetailsScreen(
                              userName: username,
                              motivationQuote: motivationQuote,
                            );
                          },
                        ),
                      );
                      if (result != null && result) {
                        _loadUsername();
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'User Details',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    leading: CustomSvgPicture(
                      path: "assets/images/leading_element.svg",
                      isColorFilter: true,
                    ),

                    trailing: CustomSvgPicture(
                      path: "assets/images/arrow_element.svg",
                      isColorFilter: true,
                    ),
                  ),

                  SizedBox(height: 18),
                  Divider(thickness: 1),
                  SizedBox(height: 13),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    leading: CustomSvgPicture(
                      path: "assets/images/dark.svg",
                      isColorFilter: true,
                    ),

                    trailing: ValueListenableBuilder(
                      valueListenable: ThemeController.themeNotifier,
                      builder: (BuildContext context, value, Widget? child) {
                        return Switch(
                          value: value == ThemeMode.dark,
                          onChanged: (value) {
                            ThemeController.toggleTheme();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(thickness: 1),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () async {
                      PreferencesManager().remove('username');
                      PreferencesManager().remove('motivation_quote');
                      PreferencesManager().remove('task');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return WelcomeScreen();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Log Out',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    leading: CustomSvgPicture(
                      path: 'assets/images/logout.svg',
                      isColorFilter: true,
                    ),

                    trailing: CustomSvgPicture(
                      path: "assets/images/arrow_element.svg",
                      isColorFilter: true,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
