import 'package:flutter/material.dart';
import 'package:json_editor/entities/json/json_node.dart';

class CollapsibleTreeNode extends StatefulWidget {
  final JsonNode jsonNode;

  const CollapsibleTreeNode({required this.jsonNode});

  @override
  _CollapsibleTreeNodeState createState() => _CollapsibleTreeNodeState();
}

class _CollapsibleTreeNodeState extends State<CollapsibleTreeNode> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(widget.jsonNode.key ?? 'Node'),
          trailing: _isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded && widget.jsonNode.data is Map)
          ...(widget.jsonNode.data as Map).entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CollapsibleTreeNode(jsonNode: JsonNode(data: entry.value, key: entry.key)),
            );
          }).toList(),
        if (_isExpanded && widget.jsonNode.data is List)
          ...(widget.jsonNode.data as List).asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CollapsibleTreeNode(jsonNode: JsonNode(data: entry.value, key: entry.key.toString())),
            );
          }).toList(),
      ],
    );
  }
}