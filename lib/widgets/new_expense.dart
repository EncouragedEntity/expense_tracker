import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/fields/amount_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/category.dart';
import 'fields/category_dropdown.dart';
import 'fields/title_field.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  bool isDateSelected = false;
  String datePickerButtonText = '';
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime? selectedDate;
  Category? selectedCategory = Category.leisure;

  @override
  void initState() {
    _titleController = TextEditingController();
    _amountController = TextEditingController();

    super.initState();
  }

  Future<void> _showDatePicker() async {
    var now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        isDateSelected = true;
        selectedDate = picked;
      });
    }
  }

  void onCategoryChange(Category? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  void _submitExpense() {
    var selectedAmount = double.tryParse(_amountController.text);
    if (selectedAmount == null ||
        _titleController.text.isEmpty ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('All fields must be initialized'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                )
              ],
            );
          });
      return;
    }
    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: selectedAmount,
      date: selectedDate!,
      category: selectedCategory!,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    datePickerButtonText = isDateSelected
        ? DateFormat.yMMMd().format(selectedDate!)
        : 'No date selected';
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TitleFormField(
                          maxLength: 50,
                          controller: _titleController,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: AmountFormField(
                          controller: _amountController,
                        ),
                      ),
                    ],
                  )
                else
                  TitleFormField(
                    maxLength: 50,
                    controller: _titleController,
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategoryDropdown(
                        onChanged: onCategoryChange,
                        selectedCategory: selectedCategory,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          _showDatePicker();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(datePickerButtonText),
                            const SizedBox(width: 8),
                            const Icon(Icons.date_range),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: AmountFormField(
                          controller: _amountController,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          _showDatePicker();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(datePickerButtonText),
                            const SizedBox(width: 8),
                            const Icon(Icons.date_range),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 30,
                ),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: _submitExpense,
                        child: const Text('Save expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      CategoryDropdown(
                        onChanged: onCategoryChange,
                        selectedCategory: selectedCategory,
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: _submitExpense,
                        child: const Text('Save expense'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
