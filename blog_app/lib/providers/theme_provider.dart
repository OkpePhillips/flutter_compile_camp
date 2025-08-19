import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enum to represent theme modes
enum AppThemeMode { light, dark }

/// State provider to store current theme
final themeProvider = StateProvider<AppThemeMode>((ref) => AppThemeMode.light);

/// Light theme
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 243, 175, 16),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 237, 237, 224),
  useMaterial3: true,
);

/// Dark theme
final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
);
