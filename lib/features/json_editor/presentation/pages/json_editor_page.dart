import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/json_editor/presentation/controllers/json_editor_controller.dart';

import '../../../../shared/widgets/json_breadcrumbs.dart';
import '../../../../shared/widgets/json_tree_view.dart';
import '../widgets/editor.dart';

class JsonEditorPage extends StatelessWidget {
  static const String route = '/json_editor';

  final JsonEditorController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Editor'),
        actions: [
          Obx(() => IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _controller.canUndo ? _controller.undo : null,
          )),
          Obx(() => IconButton(
            icon: const Icon(Icons.redo),
            onPressed: _controller.canRedo ? _controller.redo : null,
          )),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _controller.saveJson('current'),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (_controller.currentNode == null) {
          return const Center(child: Text('No JSON loaded'));
        }
        
        return Column(
          children: [
            JsonBreadcrumbs(path: [_controller.selectedPath]),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: JsonTreeView(
                      node: _controller.currentNode!,
                      onNodeSelected: (path) => _controller.setSelectedPath(path),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    flex: 1,
                    child: JsonNodeEditor(
                      node: _controller.currentNode!,
                      selectedPath: _controller.selectedPath,
                      onEdit: _controller.editNode,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNodeDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNodeDialog(BuildContext context) {
    _controller.loadJson("");
    // Implementation for add node dialog
  }
}