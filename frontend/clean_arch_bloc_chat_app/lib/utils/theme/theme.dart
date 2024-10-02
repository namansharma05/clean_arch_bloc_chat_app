import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121B22),
    secondaryHeaderColor: const Color.fromARGB(255, 43, 55, 63),
    primaryColor: const Color(0XFF25D366),
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: Color(0XFFFFFFFF),
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0XFFFFFFFF),
        fontSize: 20,
      ),
    ),
  );
}
