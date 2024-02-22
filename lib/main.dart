import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  Expenses(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
