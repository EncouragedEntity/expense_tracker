import 'package:flutter/material.dart';

class TitleFormField extends StatefulWidget {
  final int maxLength;
  final TextEditingController controller;

  const TitleFormField({
    super.key,
    required this.maxLength,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TitleFormFieldState createState() => _TitleFormFieldState();
}

class _TitleFormFieldState extends State<TitleFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            label: Text(
              'Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          controller: widget.controller,
          maxLength: widget.maxLength,
        ),
      ],
    );
  }
}
