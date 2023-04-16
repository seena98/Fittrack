import 'package:flutter/material.dart';

///one light theme is defined here
class Themes {
  ///access object globally
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
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: const Color(0xffB1B1B1),
      filled: true,
      fillColor: const Color(0xffB3B6BC),
      focusColor: const Color(0xffB1B1B1),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffe5e5ea), width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'inter',
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffB1B1B1), width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffB1B1B1), width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffE5E5EA), width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      counterStyle: const TextStyle(
        color: Color(0xffB1B1B1),
        fontSize: 16,
        fontFamily: 'inter',
      ),
      helperStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'inter',
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'inter',
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
    ),
  );
}
