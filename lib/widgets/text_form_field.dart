import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/widgets/custom_text_form_field.dart';
import 'package:flutter_mastering_course/screens/main_screen.dart';

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
            decoration: InputDecoration(hintText: 'e.g Youssef Emad'),
            style: Theme.of(context).textTheme.labelSmall,
            // cursorColor: Colors.red,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 40),
            ),
            onPressed: () async {
              if (_key.currentState?.validate() ?? false) {
                await PreferencesManager().setString(
                  'username',
                  controller.value.text,
                );
                String? username = PreferencesManager().getString('username');
                print(username);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MainScreen();
                    },
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter your name')),
                );
              }
            },
            child: Text('Lets Get Started'),
          ),
        ],
      ),
    );
  }
}
