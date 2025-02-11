import 'package:flutter/material.dart';

class JsonBreadcrumbs extends StatelessWidget {
  final List<String> path;

  const JsonBreadcrumbs({required this.path});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: path.map((segment) {
        return Text(
          '$segment > ',
          style: TextStyle(fontWeight: FontWeight.bold),
        );
      }).toList(),
    );
  }
}