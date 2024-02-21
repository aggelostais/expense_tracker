import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  const Expenses(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
