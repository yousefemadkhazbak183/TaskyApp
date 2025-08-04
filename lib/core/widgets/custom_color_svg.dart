import 'package:flutter/material.dart';

class CustomColorSvg {
  static ColorFilter primaryColorFilter(BuildContext context) {
    return ColorFilter.mode(
      Theme.of(context).colorScheme.primary,
      BlendMode.srcIn,
    );
  }

  static ColorFilter scrimColorFilter(BuildContext context) {
    return ColorFilter.mode(
      Theme.of(context).colorScheme.scrim,
      BlendMode.srcIn,
    );
  }
}
