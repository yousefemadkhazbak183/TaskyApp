import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  scaffoldBackgroundColor: const Color(0xFFF6F7F9),
  colorScheme: const ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    surface: Color(0xFF9E9E9E),
    primary: Color(0xFF161F1B),
    secondary: Color(0xFF6A6A6A),
    inversePrimary: Color(0xFFD1DAD6),
    scrim: Color(0xFF3A4640),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFFCF),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFF6F7F9),
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: const Color(0xFFFFFCFC),
      fontSize: AppSizes.sp20,
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return const Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return const Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  dividerTheme: const DividerThemeData(color: Color(0xFFD1DAD6)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF15B86C),
      foregroundColor: const Color(0xFFFFFCFC),
    ),
  ),

  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF161F1B),
    ),
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF161F1B),
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      color: const Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: AppSizes.sp16,
      color: const Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: AppSizes.sp14,
      color: const Color(0xFF3A4640),
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: const Color(0xFF6A6A6A),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: const Color(0xFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(color: Colors.black, fontSize: AppSizes.sp16),
    headlineSmall: TextStyle(
      color: const Color(0xFF15B86c),
      fontSize: AppSizes.sp14,
    ),
    bodyMedium: TextStyle(
      fontSize: AppSizes.sp20,
      color: const Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: const Color(0xFF3A4640),
      fontSize: AppSizes.h16,
    ),
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    focusColor: const Color(0xFFD1DAD6),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: const BorderSide(color: Color(0xFFD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: const BorderSide(color: Colors.red),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: const BorderSide(color: Color(0xFFD1DAD6)),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: const BorderSide(color: Color(0xFFD1DAD6)),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: const Color(0xFFD1DAD6), width: AppSizes.w2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF161F1B)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF14A662),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      side: BorderSide(color: const Color(0xFF15B86C), width: AppSizes.w2),
    ),
    elevation: 2,
    shadowColor: const Color(0xFF15B86C),
  ),
);
