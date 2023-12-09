import 'package:expense_tracker/screens/SplashScreen.dart';
import 'package:expense_tracker/screens/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColor = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kDarkColor = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColor,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColor.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColor.primaryContainer,
            foregroundColor: kDarkColor.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColor,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColor.onPrimaryContainer,
          foregroundColor: kColor.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColor.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColor.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleMedium: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: kColor.onSecondaryContainer,
                fontSize: 16,
              ),
              titleLarge: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: kColor.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    ),
  );
}
