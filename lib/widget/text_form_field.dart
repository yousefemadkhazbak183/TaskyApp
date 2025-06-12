import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/widget/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'e.g Youssef Emad',
              hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
              filled: true,
              fillColor: Color(0xFF282828),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            cursorColor: Colors.white,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF15B86C),
              foregroundColor: Color(0xFFFFFCFC),
              fixedSize: Size(MediaQuery.of(context).size.width, 40),
            ),
            onPressed: () async {
              if (_key.currentState?.validate() ?? false) {
                final pref = await SharedPreferences.getInstance();
                await pref.setString(
                  'username',
                  controller.value.text,
                );
                String? username = pref.getString('username');
                print(username);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HomeScreen();
                    },
                  ),
                );
              } else {
                /// ToDo: SnackBar.
              }
            },
            child: Text('Lets Get Started'),
          ),
        ],
      ),
    );
  }
}
