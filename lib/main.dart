import 'package:flutter/material.dart';

import 'widgets/expenses.dart';

final colorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 170, 0, 150));

final darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: colorScheme.onPrimaryContainer,
            foregroundColor: colorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: colorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkColorScheme.primaryContainer,
            foregroundColor: darkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const Expenses(),
    ),
  );
}
