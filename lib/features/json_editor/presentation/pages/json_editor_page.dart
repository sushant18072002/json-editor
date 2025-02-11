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
            JsonBreadcrumbs(
              path: _controller.currentPath,
              onPathSelected: _controller.setSelectedPath,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: JsonTreeView(
                        node: _controller.currentNode!,
                        selectedPath: _controller.selectedPath,
                        onNodeSelected: _controller.setSelectedPath,
                        onNodeMoved: _controller.moveNode,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: JsonNodeEditor(
                        node: _controller.selectedNode!,
                        onEdit: _controller.editNode,
                        selectedPath: _controller.selectedPath,
                      ),
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
    _controller.loadJson("type");
    // Implementation for add node dialog
  }
}