import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool? value) => onChanged(value),
      activeColor: Color(0xFF15B86C),
    );
  }
}
