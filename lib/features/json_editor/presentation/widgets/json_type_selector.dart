import 'package:flutter/material.dart';

class JsonTypeSelector extends StatelessWidget {
  final Function(String) onTypeSelected;

  const JsonTypeSelector({required this.onTypeSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: ['String', 'Number', 'Boolean', 'Object', 'Array']
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onTypeSelected(value);
        }
      },
      hint: Text('Select Type'),
    );
  }
}