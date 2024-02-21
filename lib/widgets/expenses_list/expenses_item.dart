import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(expense.icon, color: Colors.grey, size: 30), // Use the icon property of the expense object (Expense class
                  const SizedBox(width: 5),
                  Text(
                    expense.formattedDate,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(), // Spacer is a widget that takes up available space between widgetss
                  Text(
                    '${expense.amount.toStringAsFixed(2)} €', // AsFixed(2):2 decimal places, \$ to escape the dollar sign
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
