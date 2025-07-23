import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.maxLines,
    required this.hintText,
    required this.controller,
    this.validator,
    required this.title,
  });
  final TextEditingController controller;
  final String title;
  final int? maxLines;
  final String hintText;
  final Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 16)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
            filled: true,
            fillColor: Color(0xFF282828),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          maxLines: maxLines,
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
