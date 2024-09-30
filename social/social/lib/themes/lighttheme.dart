// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 212, 163, 115),
    elevation: 5,
  ),
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 254, 250, 224),
    primary: const Color.fromARGB(255, 250, 237, 205),
    secondary: const Color.fromARGB(255, 212, 163, 115),
  ),
);