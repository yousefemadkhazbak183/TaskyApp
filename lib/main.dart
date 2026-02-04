import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/file_storage_manager.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/theme/dark_theme.dart';
import 'package:flutter_mastering_course/core/theme/light_theme.dart';
import 'package:flutter_mastering_course/core/theme/theme_controller.dart';
import 'package:flutter_mastering_course/features/navigation/main_screen.dart';
import 'package:flutter_mastering_course/features/tasks/controllers/tasks_controller.dart';
import 'package:flutter_mastering_course/features/welcome/welcome_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PreferencesManager().init();
  ThemeController().init();
  final String? username = PreferencesManager().getString('username');
  await FileStorageManager().init();
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController(),
          child: ScreenUtilInit(
            designSize: const Size(375, 809),
            minTextAdapt: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: value,
                home: username == null ? WelcomeScreen() : const MainScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
