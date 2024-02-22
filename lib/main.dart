import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/home.dart';

// fromSeed method creates a new ColorScheme object with the specified seed color
var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple.shade200);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // copyWith method creates a new ThemeData object with the specified attributes
      // but still using the default values for the rest of the attributes
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        // default configuration for Card widgets
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          // margin: EdgeInsets.all(10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          ),
        ),
        // textTheme: const TextTheme().copyWith(
        //   headline1: ThemeData().textTheme.headline1!.copyWith(...),
        //   bodyLarge: TextStyle(color: kColorScheme.onPrimaryContainer),
        //   bodyMedium: TextStyle(color: kColorScheme.onPrimaryContainer),
        // ),
      ),
      home: const Expenses(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
