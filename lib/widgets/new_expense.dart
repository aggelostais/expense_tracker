import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(
      {super.key, required this.onAddExpense}); // const constructor, so the object is immutable, it cannot be changed after it has been created

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
    return Padding(
      // padding to have some space around the modal
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                labelText: 'Title'), // label of the text field
            maxLength: 40,
            controller: _titleController,
          ),
          Row(
            children: [
              // TextField in a Row should be wrapped in an Expanded widget to avoid overflow problems
              // Textfield wants to take as much space as possible with the row not restricting the space taken
              // so it causes an overflow
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    suffixText: ' €',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _amountController,
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : DateFormat('dd/MM/yyyy').format(
                              _selectedDate!), //! after a variable means that it is never null, as we checked it befores
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
              height:
                  40), // add some space between the two rows (textfields and buttons
          Row(
            children: [
              // we access the values property of the enum class Category
              // and map it to a list of DropdownMenuItem widgets
              DropdownButton(
                hint: const Text('Category'), // title field for the dropdown
                value:
                    _selectedCategory, // value that is stored internally in the widget
                items: Category.values.map((Category category) {
                  return DropdownMenuItem(
                    value:
                        category, // value that is stored internally in the widget
                    child: Row(
                      children: [
                        Icon(categoryIcons[category]),
                        const SizedBox(width: 15),
                        Text(category.name[0].toUpperCase() +
                            category.name.substring(1)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => _selectCategory(value),
              ),
              const Spacer(),
              IconButton(
                //Cancel button
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  Navigator.pop(context); //close the modal
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}














// class _NewExpenseState extends State<NewExpense>{
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();
//   DateTime? _selectedDate;

//   void _submitData() {
//     final enteredTitle = _titleController.text;
//     final enteredAmount = double.parse(_amountController.text);

//     if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
//       return;
//     }

//     // widget is a special property that is available in the state object
//     // it is a pointer to the widget that the state object is connected to
//     // in this case, it is a pointer to the NewExpense widget
//     widget.addExpense(
//       enteredTitle,
//       enteredAmount,
//       _selectedDate,
//     );

//     // close the modal bottom sheet
//     Navigator.of(context).pop();
//   }

//   void _presentDatePicker() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2021),
//       lastDate: DateTime.now(),
//     ).then((pickedDate) {
//       if (pickedDate == null) {
//         return;
//       }
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Card(
//         elevation: 5,
//         child: Container(
//           padding: EdgeInsets.only(
//             top: 10,
//             left: 10,
//             right: 10,
//             bottom: MediaQuery.of(context).viewInsets.bottom + 10,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               TextField(
//                 decoration: const InputDecoration(labelText: 'Title'),
//                 controller: _titleController,
//                 onSubmitted: (_) => _submitData(),
//               ),
//               TextField(
//                 decoration: const InputDecoration(labelText: 'Amount'),
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 onSubmitted: (_) => _submitData(),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       _selectedDate == null
//                           ? 'No Date Chosen!'
//                           : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: _presentDatePicker,
//                     child: const Text(
//                       'Choose Date',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: _submitData,
//                 child: const Text('Add Expense'),
//               ),
//            ],
//           ),
//         ),
//       ),
//     );
//   }
// }