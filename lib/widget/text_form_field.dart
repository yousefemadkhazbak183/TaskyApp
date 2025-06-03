import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'e.g @example',
        hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
        filled: true,
        fillColor: Color(0xFF282828),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      cursorColor: Colors.white,
    );
  }
}
