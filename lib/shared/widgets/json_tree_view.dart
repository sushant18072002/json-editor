import 'package:flutter/material.dart';
import 'package:json_editor/entities/json/json_node.dart';
import 'package:json_editor/shared/widgets/interactive/collapsible_tree_node.dart';

class JsonTreeView extends StatelessWidget {
  final JsonNode node;
  final Function(String) onNodeSelected;

  const JsonTreeView({
    required this.node,
    required this.onNodeSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TreeNodeWidget(
          node: node,
          onNodeSelected: onNodeSelected,
        ),
      ],
    );
  }
}

class TreeNodeWidget extends StatefulWidget {
  final JsonNode node;
  final Function(String) onNodeSelected;
  final int depth;

  const TreeNodeWidget({
    required this.node,
    required this.onNodeSelected,
    this.depth = 0,
    Key? key,
  }) : super(key: key);

  @override
  _TreeNodeWidgetState createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.node.children.isNotEmpty;
    final padding = EdgeInsets.only(left: widget.depth * 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            widget.onNodeSelected(widget.node.path);
            if (hasChildren) {
              setState(() => _isExpanded = !_isExpanded);
            }
          },
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (hasChildren)
                  Icon(_isExpanded ? Icons.expand_more : Icons.chevron_right),
                Text(
                  widget.node.key ?? 'root',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 8),
                Text(
                  _getNodePreview(widget.node),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded && hasChildren)
          ...widget.node.children.map((child) => TreeNodeWidget(
            node: child,
            onNodeSelected: widget.onNodeSelected,
            depth: widget.depth + 1,
          )),
      ],
    );
  }

  String _getNodePreview(JsonNode node) {
    if (node.type == JsonNodeType.object) {
      return '{...}';
    }
    if (node.type == JsonNodeType.array) {
      return '[${node.children.length}]';
    }
    return node.data.toString();
  }
}
