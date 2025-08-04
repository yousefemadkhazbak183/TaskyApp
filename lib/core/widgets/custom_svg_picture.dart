import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/widgets/custom_color_svg.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  CustomSvgPicture({
    super.key,
    required this.path,
    required this.isColorFilter,
    this.width,
    this.height,
  });
  CustomSvgPicture.withoutFilterColor({
    super.key,
    required this.path,
    this.width,
    this.height,
  }) : isColorFilter = false;
  final String path;
  bool isColorFilter = true;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: isColorFilter
          ? CustomColorSvg.scrimColorFilter(context)
          : null,
    );
  }
}
