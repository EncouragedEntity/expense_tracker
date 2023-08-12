import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, {super.key, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.25),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        );
      },
    );
  }
}
