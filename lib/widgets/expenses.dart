import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

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
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  // there is a global context variable that is available in the state object
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
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
        body: Column(
          children: [
            const Text('Expenses Chart'),
            Expanded(
              child: ExpensesList(
                expenses: _registeredExpenses,
                onRemoveExpense: _removeExpense,
              ),
            ),
          ],
        ));
  }
}
