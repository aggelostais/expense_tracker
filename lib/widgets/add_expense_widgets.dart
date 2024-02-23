import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key, required this.titleController});
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: const InputDecoration(
            labelText: 'Title'), // label of the text field
        maxLength: 40,
        controller: titleController,
      ),
    );
  }
}

class AmountInput extends StatelessWidget {
  const AmountInput({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    // TextField in a Row should be wrapped in an Expanded widget to avoid overflow problems
    // Textfield wants to take as much space as possible with the row not restricting the space taken
    // so it causes an overflow
    return Expanded(
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Amount',
          suffixText: ' €',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: amountController,
      ),
    );
  }
}

class DateInput extends StatelessWidget {
  const DateInput(
      {super.key, required this.selectedDate, required this.presentDatePicker});
  final DateTime? selectedDate;
  final Function() presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            selectedDate == null
                ? 'No Date Selected'
                : DateFormat('dd/MM/yyyy').format(
                    selectedDate!), //! after a variable means that it is never null, as we checked it befores
          ),
          IconButton(
            onPressed: presentDatePicker,
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }
}


// we access the values property of the enum class Category
// and map it to a list of DropdownMenuItem widgets
class CategoryInput extends StatelessWidget {
  const CategoryInput(
      {super.key,
      required this.selectedCategory,
      required this.selectCategory});
  final Category? selectedCategory;
  final Function(Category?) selectCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('Category'), // title field for the dropdown
      value: selectedCategory, // value that is stored internally in the widget
      items: Category.values.map((Category category) {
        return DropdownMenuItem(
          value: category, // value that is stored internally in the widget
          child: Row(
            children: [
              Icon(categoryIcons[category]),
              const SizedBox(width: 15),
              Text(category.name[0].toUpperCase() + category.name.substring(1)),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => selectCategory(value),
    );
  }
}
