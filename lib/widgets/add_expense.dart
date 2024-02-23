import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/add_expense_widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(
      {super.key,
      required this.onAddExpense}); // const constructor, so the object is immutable, it cannot be changed after it has been created

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController =
      TextEditingController(); //object optimized for text input
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController
        .text); //parse the string to a double, if not parsable null
    final amountValid = enteredAmount != null && enteredAmount > 0;

    //Error message if the input is invalid
    if (enteredTitle.trim().isEmpty ||
        !amountValid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter valid input values.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }

    //widget. is a special property to access the widget that the state object is connected to
    //availble only in state classes that extend a widget class
    widget.onAddExpense(Expense(
      title: enteredTitle,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory!,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // tell flutter that this controllers are no longer needed, mandatory to avoid memory leaks
    _titleController
        .dispose(); //dispose of the controller when the state object is removed
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  _presentDatePicker() async {
    //function to show the date picker and stor
    final now = DateTime.now();
    // Returns a future special object which holds a value that will be available in the future
    // await waits for the future to resolve and then continues with the execution of the code
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });

    // alternative to async: then is a method that is called for that future object when the user has selected a date
    // .then((pickedDate) {
    //   if (pickedDate == null) {
    //     return;
    //   }
  }

  _selectCategory(Category? category) {
    if (category == null) {
      return;
    }
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; // Extra information about UI elements that overlap parts of the UI
    return LayoutBuilder(
      // LayoutBuilder is a widget that provides the constraints of the parent widget to its builder function
      builder: (context, constrains) {
        final width = constrains.maxWidth;
        return SizedBox(
          // With sized box it takes the whole screen height
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              // padding to have some space around the modal
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: width < 600
                  ? Column(
                      children: [
                        Row(
                          children: [
                            TitleInput(titleController: _titleController),
                          ],
                        ),
                        Row(
                          children: [
                            AmountInput(amountController: _amountController),
                            DateInput(
                                selectedDate: _selectedDate,
                                presentDatePicker: _presentDatePicker)
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            CategoryInput(
                              selectedCategory: _selectedCategory,
                              selectCategory: _selectCategory,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                Navigator.pop(context); //close the modal
                              },
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: _submitData,
                              child: const Text('Add Expense'),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleInput(titleController: _titleController),
                            const SizedBox(width: 20),
                            AmountInput(amountController: _amountController)
                          ],
                        ),
                        Row(
                          children: [
                            CategoryInput(
                              selectedCategory: _selectedCategory,
                              selectCategory: _selectCategory,
                            ),
                            DateInput(
                                selectedDate: _selectedDate,
                                presentDatePicker: _presentDatePicker)
                          ],
                        ),
                        const SizedBox(
                            height:
                                30), // add some space between the two rows (textfields and buttons)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                Navigator.pop(context); //close the modal
                              },
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: _submitData,
                              child: const Text('Add Expense'),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
