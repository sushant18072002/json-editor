import 'package:flutter/material.dart';
import 'package:json_editor/entities/json/json_node.dart';
import 'package:json_editor/shared/widgets/interactive/collapsible_tree_node.dart';

class JsonTreeView extends StatelessWidget {
  final JsonNode node;
  final Function(String) onNodeSelected;
  final Function(JsonNode, JsonNode)? onNodeMoved;
  final String? selectedPath;

  const JsonTreeView({
    required this.node,
    required this.onNodeSelected,
    this.onNodeMoved,
    this.selectedPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TreeNodeWidget(
        node: node,
        onNodeSelected: onNodeSelected,
        onNodeMoved: onNodeMoved,
        selectedPath: selectedPath,
        depth: 0,
      ),
    );
  }
}

class TreeNodeWidget extends StatefulWidget {
  final JsonNode node;
  final Function(String) onNodeSelected;
  final Function(JsonNode, JsonNode)? onNodeMoved;
  final String? selectedPath;
  final int depth;

  const TreeNodeWidget({
    required this.node,
    required this.onNodeSelected,
    this.onNodeMoved,
    this.selectedPath,
    required this.depth,
    Key? key,
  }) : super(key: key);

  @override
  _TreeNodeWidgetState createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool _isExpanded = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // Auto-expand if this node is in the selected path
    if (widget.selectedPath != null) {
      _isExpanded = widget.selectedPath!.startsWith(widget.node.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.node.children.isNotEmpty;
    final isSelected = widget.selectedPath == widget.node.path;
    final theme = Theme.of(context);

    return DragTarget<JsonNode>(
      onWillAccept: (data) => data != null && data != widget.node,
      onAccept: (data) {
        if (widget.onNodeMoved != null) {
          widget.onNodeMoved!(data, widget.node);
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<JsonNode>(
          data: widget.node,
          feedback: Material(
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: theme.colorScheme.surface,
              child: _buildNodeContent(isSelected),
            ),
          ),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: Container(
              color: _getBackgroundColor(isSelected, theme),
              child: Column(
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
                      padding: EdgeInsets.only(left: widget.depth * 24.0),
                      child: _buildNodeContent(isSelected),
                    ),
                  ),
                  if (_isExpanded && hasChildren)
                    ...widget.node.children.map((child) => TreeNodeWidget(
                      node: child,
                      onNodeSelected: widget.onNodeSelected,
                      onNodeMoved: widget.onNodeMoved,
                      selectedPath: widget.selectedPath,
                      depth: widget.depth + 1,
                    )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNodeContent(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          if (widget.node.children.isNotEmpty)
            Icon(
              _isExpanded ? Icons.expand_more : Icons.chevron_right,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          const SizedBox(width: 4),
          _buildTypeIcon(),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.node.key ?? 'root',
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : null,
                  ),
                ),
                if (_isHovered || isSelected)
                  Text(
                    widget.node.path,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.white70 : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          _buildValuePreview(),
        ],
      ),
    );
  }

  Widget _buildTypeIcon() {
    IconData icon;
    Color color;

    switch (widget.node.type) {
      case JsonNodeType.object:
        icon = Icons.data_object;
        color = Colors.blue;
        break;
      case JsonNodeType.array:
        icon = Icons.list;
        color = Colors.green;
        break;
      case JsonNodeType.string:
        icon = Icons.text_fields;
        color = Colors.orange;
        break;
      case JsonNodeType.number:
        icon = Icons.numbers;
        color = Colors.purple;
        break;
      case JsonNodeType.boolean:
        icon = Icons.check_circle_outline;
        color = Colors.red;
        break;
      case JsonNodeType.null_:
        icon = Icons.block;
        color = Colors.grey;
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
    }

    return Icon(icon, size: 16, color: color);
  }

  Widget _buildValuePreview() {
    if (widget.node.type == JsonNodeType.object) {
      return Text(
        '{${widget.node.children.length}}',
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      );
    }
    if (widget.node.type == JsonNodeType.array) {
      return Text(
        '[${widget.node.children.length}]',
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      );
    }
    if (widget.node.type == JsonNodeType.string) {
      final value = widget.node.data.toString();
      return Text(
        '"${value.length > 20 ? '${value.substring(0, 17)}...' : value}"',
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      );
    }
    return Text(
      widget.node.data.toString(),
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }

  Color _getBackgroundColor(bool isSelected, ThemeData theme) {
    if (isSelected) {
      return theme.colorScheme.primary;
    }
    if (_isHovered) {
      return theme.hoverColor;
    }
    return Colors.transparent;
  }
}
