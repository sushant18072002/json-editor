import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/json_editor/presentation/controllers/json_editor_controller.dart';

import '../../../../entities/json/json_node.dart';

class NodeContextMenu extends StatelessWidget {
  final JsonNode node;
  final JsonNode parentNode;

  const NodeContextMenu({
    Key? key, 
    required this.node,
    required this.parentNode,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final JsonEditorController _controller = Get.find();

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('Edit'),
          onTap: () {
        
          },
        ),
        PopupMenuItem(
          child: Text('Delete'),
          onTap: () {
            //_controller.deleteNode(parentNode, node);
          },
        ),
      ],
    );
  }
}
