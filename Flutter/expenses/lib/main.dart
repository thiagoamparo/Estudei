import 'package:flutter/material.dart';

import 'components/expenses.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: Color(0xFF2E3A8C),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF2C2C2C),
    fontFamily: 'Tomorrow',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Keania One',
      ),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF2E3A8C),
      secondary: Color(0xFF3F51B5),
      tertiary: Color(0xFF4758C7),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onTertiary: Color(0xFFFFFFFF),
      surface: Color(0xFF181A29),
      brightness: Brightness.dark,
    ),
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: Color(0xFF448AFF),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    fontFamily: 'Tomorrow',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Keania One',
      ),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
        fontSize: 10,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF448AFF),
      secondary: Color(0xFFFFFFFF),
      tertiary: Color(0xFF2979FF),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF2979FF),
      onTertiary: Color(0xFF448AFF),
      surface: Color(0xFFE3F2FD),
      onSurface: Color(0xFF448AFF),
      onBackground: Color(0xFF448AFF),
      brightness: Brightness.light,
    ),
  );

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: MyApp.light,
      darkTheme: MyApp.dark,
      themeMode: _themeMode,
      home: ExpensesApp(
        toggleTheme: _toggleTheme,
      ),
    );
  }
}
