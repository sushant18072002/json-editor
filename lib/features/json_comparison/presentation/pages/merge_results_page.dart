import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/json_comparison/presentation/controllers/json_comparison_controller.dart';

class MergeResultsPage extends StatelessWidget {
  static const String route = '/merge_results';

  final JsonComparisonController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merge Results'),
      ),
      body: Obx(() {
        if (_controller.comparisonResult == null) {
          return Center(child: Text('No comparison results available'));
        }
        return ListView.builder(
          itemCount: _controller.comparisonResult!.differences.length,
          itemBuilder: (context, index) {
            final diff = _controller.comparisonResult!.differences[index];
            return ListTile(
              title: Text(diff.path),
              subtitle: Text('Old: ${diff.oldValue}, New: ${diff.newValue}'),
            );
          },
        );
      }),
    );
  }
}