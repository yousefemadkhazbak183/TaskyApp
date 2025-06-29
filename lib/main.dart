import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/widget/main_screen.dart';
import 'package:flutter_mastering_course/widget/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();

  String? username = pref.getString('username');
  runApp(MyApp(username: username,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),

      home: username == null ? WelcomeScreen() : MainScreen(),
    );
  }
}
