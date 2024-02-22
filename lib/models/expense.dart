import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid =
    Uuid(); //utility object used anywhere in the class to generate unique ids

enum Category {
  food,
  travel,
  leisure,
  work
} //Custom type to represent the category of the expense, treated kind of like string values

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4() {
    icon = categoryIcons[
        category]!; // Initialize the icon variable inside the constructor body
  }

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  IconData? icon; // Declare the icon variable

  String get formattedDate {
    // getter is a method but can be accessed as a property
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) // alternative constructor function
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); //where method filters the list

  double get totalExpenses {
    //getter to calculate the total expenses for a category
    return expenses.fold(
        0, (previousValue, element) => previousValue + element.amount);

    // double total = 0;
    // for (final expense in expenses) { // to loop through all items in a list
    //   total += expense.amount;
    // }
    // return total;
  }
}
