import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'expenses_list/expenses_list.dart';
import '../models/category.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Buggati',
      amount: 3000.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Pizza',
      amount: 20.50,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Laptop',
      amount: 1100,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Rubber boat',
      amount: 200,
      date: DateTime.now(),
      category: Category.traveling,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.insert(
        _registeredExpenses.indexOf(_registeredExpenses.first),
        expense,
      );
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: screenWidth < 600
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Chart(expenses: _registeredExpenses),
                  _registeredExpenses.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: Text('No expenses found'),
                          ),
                        )
                      : Expanded(
                          child: ExpensesList(
                            _registeredExpenses,
                            onRemoveExpense: _removeExpense,
                          ),
                        ),
                ],
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registeredExpenses,
                  ),
                ),
                _registeredExpenses.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text('No expenses found'),
                        ),
                      )
                    : Expanded(
                        child: ExpensesList(
                          _registeredExpenses,
                          onRemoveExpense: _removeExpense,
                        ),
                      ),
              ],
            ),
    );
  }
}
