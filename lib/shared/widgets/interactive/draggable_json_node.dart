import 'package:flutter/material.dart';
import 'package:json_editor/entities/json/json_node.dart';

class DraggableJsonNode extends StatelessWidget {
  final JsonNode jsonNode;

  const DraggableJsonNode({required this.jsonNode});

  @override
  Widget build(BuildContext context) {
    return Draggable<JsonNode>(
      data: jsonNode,
      feedback: Material(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(jsonNode.key ?? 'Node'),
        ),
      ),
      child: Text(jsonNode.key ?? 'Node'),
    );
  }
}