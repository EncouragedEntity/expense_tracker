import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'category.dart';

const uuid = Uuid();

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  IconData? get iconDataFromCategory {
    return categoryIcons[category];
  }

  String get fomattedDate {
    return DateFormat.yMMMd().format(date);
  }
}

