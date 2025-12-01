import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF181818),
  colorScheme: const ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    surface: Color(0xFF6D6D6D),
    primary: Color(0xFFFFFCFC),
    secondary: Color(0xFFA0A0A0),
    inversePrimary: Color(0xFF6E6E6E),
    scrim: Color(0xFFC6C6C6),
  ),
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF181818),
    centerTitle: false,
    titleTextStyle: TextStyle(color: const Color(0xFFFFFCFC), fontSize: 20.sp),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFFCF),
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
  dividerTheme: const DividerThemeData(color: Color(0xFF6E6E6E)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(const Color(0xFFFFFCFC)),
    ),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFCFC),
    ),
    displayMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFFFF),
    ),
    displayLarge: TextStyle(
      fontSize: 32.sp,
      color: const Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(color: Colors.white, fontSize: 16.sp),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      color: const Color(0xFFC6C6C6),
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      color: const Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),

    // For Done Tasks.
    titleLarge: TextStyle(
      color: const Color(0xFFA0A0A0),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: const Color(0xFFA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
    headlineSmall: TextStyle(color: const Color(0xFF15B86c), fontSize: 14.sp),

    bodyMedium: TextStyle(
      fontSize: 20.sp,
      color: const Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: const Color(0xFF282828),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: const Color(0xFF9E9E9E), width: 2.w),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: const IconThemeData(color: Color(0xFFCFCFCF)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFF181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: const Color(0xFF15B86C), width: 2.w),
    ),
    elevation: 1,
    shadowColor: const Color(0xFF15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
    ),
  ),
);
