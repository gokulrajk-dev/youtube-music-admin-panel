
import 'package:flutter/material.dart';

import '../config/form_field_config.dart';

class DynamicForm extends StatelessWidget {
  final List<FormFieldConfig> fields;

  const DynamicForm({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields.map((field) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: field.label,
            ),
          ),
        );
      }).toList(),
    );
  }
}