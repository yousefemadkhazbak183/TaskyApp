import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    final bool result = PreferencesManager().getBool("theme") ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool('theme', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool('theme', true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
