import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/json_comparison/presentation/controllers/json_comparison_controller.dart';
import 'package:json_editor/features/json_comparison/presentation/widgets/split_view_comparator.dart';

class JsonComparisonPage extends StatelessWidget {
  static const String route = '/json_comparison';

  final JsonComparisonController _controller = Get.put(JsonComparisonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Comparison'),
      ),
      body: Column(
        children: [
          Expanded(child: SplitViewComparator()),
          ElevatedButton(
            onPressed: _controller.compareJson,
            child: Text('Compare'),
          ),
        ],
      ),
    );
  }
}