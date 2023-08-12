import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountFormField extends StatelessWidget {
  final TextEditingController controller;

  const AmountFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            _MoneyInputFormatter(),
          ],
          decoration: const InputDecoration(
            label: Text(
              'Amount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            hintText: '0.00',
          ),
        ),
      ],
    );
  }
}

class _MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final parts = newValue.text.split('.');
    if (parts.length > 1) {
      if (parts[1].length > 2) {
        return oldValue; 
      }
    }

    if (double.tryParse(newValue.text) == null) {
      return oldValue;
    }

    return newValue;
  }
}
