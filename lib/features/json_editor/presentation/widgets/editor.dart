import 'package:flutter/material.dart';

import '../../../../entities/json/json_node.dart';

class JsonNodeEditor extends StatelessWidget {
  final JsonNode node;
  final String selectedPath;
  final Function(String, dynamic) onEdit;

  const JsonNodeEditor({
    required this.node,
    required this.selectedPath,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedNode = _findNodeByPath(node, selectedPath);
    if (selectedNode == null) {
      return const Center(child: Text('Select a node to edit'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Path: ${selectedNode.path}'),
          const SizedBox(height: 8),
          Text('Type: ${selectedNode.type.toString().split('.').last}'),
          const SizedBox(height: 16),
          _buildEditorForType(selectedNode),
        ],
      ),
    );
  }

  Widget _buildEditorForType(JsonNode node) {
    switch (node.type) {
      case JsonNodeType.string:
        return _StringEditor(
          value: node.data as String,
          onChanged: (value) => onEdit(node.path, value),
        );
      case JsonNodeType.number:
        return _NumberEditor(
          value: node.data as num,
          onChanged: (value) => onEdit(node.path, value),
        );
      case JsonNodeType.boolean:
        return _BooleanEditor(
          value: node.data as bool,
          onChanged: (value) => onEdit(node.path, value),
        );
      case JsonNodeType.null_:
        return _NullEditor(
          onChanged: (value) => onEdit(node.path, value),
        );
      case JsonNodeType.object:
      case JsonNodeType.array:
        return Text('${node.type} cannot be edited directly');
      default:
        return Text('Unknown type: ${node.type}');
    }
  }

  JsonNode? _findNodeByPath(JsonNode root, String path) {
    if (path.isEmpty) return root;
    final parts = path.split('.');
    JsonNode current = root;
    
    for (final part in parts) {
      if (current.type == JsonNodeType.object) {
        current = current.children.firstWhere(
          (child) => child.key == part,
          orElse: () => throw JsonOperationException('Invalid path: $path'),
        );
      } else if (current.type == JsonNodeType.array) {
        final index = int.tryParse(part);
        if (index == null || index >= current.children.length) {
          throw JsonOperationException('Invalid array index: $part');
        }
        current = current.children[index];
      } else {
        throw JsonOperationException('Cannot navigate through primitive type');
      }
    }
    return current;
  }
}

class _StringEditor extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _StringEditor({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _StringEditorState createState() => _StringEditorState();
}

class _StringEditorState extends State<_StringEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'String Value',
        border: OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}

class _NumberEditor extends StatefulWidget {
  final num value;
  final ValueChanged<num> onChanged;

  const _NumberEditor({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _NumberEditorState createState() => _NumberEditorState();
}

class _NumberEditorState extends State<_NumberEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Number Value',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        final number = num.tryParse(value);
        if (number != null) {
          widget.onChanged(number);
        }
      },
    );
  }
}

class _BooleanEditor extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _BooleanEditor({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}

class _NullEditor extends StatelessWidget {
  final ValueChanged<dynamic> onChanged;

  const _NullEditor({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: 'null',
      items: const [
        DropdownMenuItem(value: 'null', child: Text('null')),
        DropdownMenuItem(value: 'string', child: Text('Convert to String')),
        DropdownMenuItem(value: 'number', child: Text('Convert to Number')),
        DropdownMenuItem(value: 'boolean', child: Text('Convert to Boolean')),
      ],
      onChanged: (value) {
        switch (value) {
          case 'string':
            onChanged('');
            break;
          case 'number':
            onChanged(0);
            break;
          case 'boolean':
            onChanged(false);
            break;
          default:
            onChanged(null);
        }
      },
    );
  }
}


// Exception Handling
class JsonOperationException implements Exception {
  final String message;
  
  JsonOperationException(this.message);
  
  @override
  String toString() => 'JsonOperationException: $message';
}

// History Management
