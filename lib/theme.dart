import 'package:flutter/material.dart';

class Themes {
  static final Themes _instance = Themes._factory();

  static Themes getInstance() => _instance;

  Themes._factory();

  ///Light theme data
  ThemeData light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: const Color(0xffB3B6BC),
    scaffoldBackgroundColor: const Color(0xffFAFAFA),
    splashColor: const Color(0xffC7C7CC),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xffB3B6BC),
      onSecondary: const Color(0xff0E172A),
      background: const Color(0xffFAFAFA),
    ),
    indicatorColor: const Color(0xff0E172A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff0E172A),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'inter',
          fontWeight: FontWeight.w700),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}
