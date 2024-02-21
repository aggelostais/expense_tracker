import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// Just output that list of expenses
class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // ListView.builder is a widget that builds a list of items on demand
    // It is not recommended to use Column for long lists as it will build all the items at once
    // builder constructor creates items only when they are visible on the screen, only when they are needed
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          title: Dismissible(
            key: ValueKey(
                expense), // Value key constructor is created with a unique value
            onDismissed: (direction) { //diection is the direction in which the user swiped
              onRemoveExpense(expense);
            },
            child: ExpenseItem(expense: expense),
          ),
        );
      },
    );
  }
}
