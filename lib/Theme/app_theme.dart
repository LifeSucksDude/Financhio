import 'package:financhio/Theme/pallete.dart';
import 'package:flutter/material.dart';

class Apptheme{
  static ThemeData theme=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.purpleColor
    )

  );
}