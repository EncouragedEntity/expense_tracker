import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleLarge ,
                ),
                const Spacer(),
                Icon(expense.iconDataFromCategory),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('\$ ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                const Icon(Icons.date_range),
                Text(expense.fomattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
