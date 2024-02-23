import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/add_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

// When we are in a state that extends class, flutter provides a context property
// that is available in the state object and can be used as a value.
// The context property is a reference to the location of a widget in the widget tree
class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 50.40,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Uber',
      amount: 32.6,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  // Adds the new expense to the list of expenses
  void _addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // clear any existing snackbar messages before showing a new one
    ScaffoldMessenger.of(context).showSnackBar(
        // ScaffoldMessenger is a widget that provides access to the nearest Scaffold
        SnackBar(
      // SnackBar is a widget that provides a lightweight feedback about an operation
      content: const Text('Expense deleted'),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        //add undo button to the snackbar
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex,
                expense); //insert the expense back to the list at its original position
          });
        },
      ),
    ));
  }

  // there is a global context variable that is available in the state object
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea:
          true, // stay away from device's unsafe area (notch, home indicator, etc.)
      isScrollControlled:
          true, // This property is used to make the modal sheet take the full screen height
      context: context,
      builder: (modalContext) {
        //builder is a function that returns a widget
        return NewExpense(
            onAddExpense:
                _addNewExpense); // we pass the function that will add the new expense to the list
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // build method is executed again when screen orientation changes
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(child: Text('No Expenses.'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          // Typically used to display buttons at the app bar
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:
                _openAddExpenseOverlay, // We pass a pointer to that method, so without ()
          ),
        ],
      ),
      body: width <
              600 // if the width is less than 600, we display the chart below the list
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              // if the width is greater than 600, we display the chart next to the list
              children: [
                SizedBox(
                  width: width / 3,
                  height: height,
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  // Always the solution when wrapped widgets don't work as expected
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
