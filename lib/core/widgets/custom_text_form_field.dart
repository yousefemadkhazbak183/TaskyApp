import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/app_sizes.dart';

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
        SizedBox(height: AppSizes.h8),
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
