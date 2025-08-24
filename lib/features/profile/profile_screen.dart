import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/storage_keys.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/core/widgets/custom_svg_picture.dart';
import 'package:flutter_mastering_course/features/profile/user_details_screen.dart';
import 'package:flutter_mastering_course/features/welcome/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  String? motivationQuote;
  bool isLoading = true;

  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    setState(() {
      username = PreferencesManager().getString(StorageKeys.username) ?? '';
      motivationQuote = PreferencesManager().getString(
        StorageKeys.motivationQuote,
      );
      imagePath = PreferencesManager().getString(StorageKeys.imagePath);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
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
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: imagePath == null
                                  ? const AssetImage(
                                      'assets/images/profile.png',
                                    )
                                  : FileImage(File(imagePath!)),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ),

                            // Camera for change image
                            GestureDetector(
                              onTap: () async {
                                _showDialogImagePicker(context, (XFile file) {
                                  _saveImage(file);
                                  setState(() {
                                    imagePath = file.path;
                                  });
                                });
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ThemeController.isDark()
                                      ? const Color(0xFF282828)
                                      : const Color(0xFFFFFFFF),
                                ),
                                child: const Icon(Icons.camera_alt),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
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
                  const SizedBox(height: 24),
                  Text(
                    'Profile Info',

                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
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

                  const SizedBox(height: 18),
                  const Divider(thickness: 1),
                  const SizedBox(height: 13),
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
                  const SizedBox(height: 8),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  ListTile(
                    onTap: () async {
                      PreferencesManager().remove(StorageKeys.username);
                      PreferencesManager().remove(StorageKeys.motivationQuote);
                      PreferencesManager().remove(StorageKeys.task);
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

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy("${appDir.path}/${file.name}");
    PreferencesManager().setString(StorageKeys.imagePath, newFile.path);
  }
}

void _showDialogImagePicker(
  BuildContext context,
  Function(XFile) selectedImage,
) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          'Choose Image',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(16),
            onPressed: () async {
              Navigator.pop(context);

              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedImage(image);
              }
            },
            child: const Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(height: 8),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(16),

            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedImage(image);
              }
            },
            child: const Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(height: 8),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
