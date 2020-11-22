import 'package:flutter/material.dart';

class CustomTheme {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2ca8e2);
  static Color darkAccent = Color(0xff2ca8e2);
  static Color lightBG = Colors.white;
  static Color darkBG = Color(0xff121212);
  static Color transparent = Colors.transparent;
  static Color dark = Colors.black;

  static ThemeData lightTheme = ThemeData(
      backgroundColor: lightBG,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBG,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      dividerColor: dark);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      backgroundColor: darkBG,
      primaryColor: darkPrimary,
      accentColor: darkAccent,
      scaffoldBackgroundColor: darkBG,
      cursorColor: darkAccent,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      dividerColor: lightPrimary);
}
