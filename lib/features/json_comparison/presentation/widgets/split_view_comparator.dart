import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/json_comparison/presentation/controllers/json_comparison_controller.dart';

import '../../../../shared/widgets/json_tree_view.dart';

class SplitViewComparator extends StatelessWidget {
  final JsonComparisonController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(() {
            if (_controller.leftJsonNode == null) {
              return Center(child: Text('No JSON loaded on the left'));
            }
            return Container();
           //return JsonTreeView(node: _controller.leftJsonNode!,onNodeSelected: null,);
          }),
        ),
        VerticalDivider(width: 1),
        Expanded(
          child: Obx(() {
            if (_controller.rightJsonNode == null) {
              return Center(child: Text('No JSON loaded on the right'));
            }
            return Container();
            //return JsonTreeView(jsonNode: _controller.rightJsonNode!);
          }),
        ),
      ],
    );
  }
}