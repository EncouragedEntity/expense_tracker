import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({
    required this.onChanged,
    required this.selectedCategory,
    super.key,
  });
  final void Function(Category?)? onChanged;
  final Category? selectedCategory;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      value: widget.selectedCategory ?? Category.leisure,
      onChanged: widget.onChanged,
      items:
          Category.values.map<DropdownMenuItem<Category>>((Category category) {
        var text = category.toString().split('.').last;
        return DropdownMenuItem<Category>(
          value: category,
          child: Text(text[0].toUpperCase() + text.substring(1)),
        );
      }).toList(),
    );
  }
}
