import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
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
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
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
