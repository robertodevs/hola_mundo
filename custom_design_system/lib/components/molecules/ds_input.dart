import 'package:custom_design_system/components/atoms/ds_textfield.dart';
import 'package:flutter/material.dart';

class DSInput extends StatelessWidget {
  const DSInput({
    super.key,
    required this.labelText,
    required this.controller,
  });

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 8),
        DSTextField(
          labelText: labelText,
          controller: controller,
        ),
      ],
    );
  }
}
