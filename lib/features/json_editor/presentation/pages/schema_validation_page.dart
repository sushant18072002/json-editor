import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/json_editor/presentation/controllers/schema_controller.dart';

class SchemaValidationPage extends StatelessWidget {
  static const String route = '/schema_validation';

  final SchemaController _controller = Get.put(SchemaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schema Validation'),
      ),
      body: Center(
        child: Text('Schema Validation Page'),
      ),
    );
  }
}