import 'package:get/get.dart';
import '../../../../entities/history/edit_action.dart';
import '../../../../entities/json/json_node.dart';
import '../../../../shared/mixins/loading_mixin.dart';
import '../../domain/usecases/crud/edit_node_usecase.dart';
import '../../domain/usecases/load_json_usecase.dart';
import '../../domain/usecases/save_json_usecase.dart';
import '../widgets/editor.dart';

class JsonEditorController extends GetxController with LoadingMixin {
  final LoadJsonUseCase _loadJsonUseCase;
  final SaveJsonUseCase _saveJsonUseCase;
  final EditNodeUseCase _editNodeUseCase;
  
  // Observables for state management
  final Rx<JsonNode?> _currentNode = Rx<JsonNode?>(null);
  final RxString _selectedPath = ''.obs;
  final RxList<EditAction> _history = RxList<EditAction>([]);
  final RxInt _historyIndex = RxInt(-1);
  final RxList<String> _bookmarks = RxList<String>([]);
  
  // Computed properties
  JsonNode? get currentNode => _currentNode.value;
  String get selectedPath => _selectedPath.value;
  bool get canUndo => _historyIndex.value > -1;
  bool get canRedo => _historyIndex.value < _history.length - 1;
  List<String> get currentPath => selectedPath.split('.');
  JsonNode? get selectedNode => _findNodeByPath(_currentNode.value, selectedPath);
  List<String> get bookmarks => _bookmarks;

  JsonEditorController({
    required LoadJsonUseCase loadJsonUseCase,
    required SaveJsonUseCase saveJsonUseCase,
    required EditNodeUseCase editNodeUseCase,
  }) : _loadJsonUseCase = loadJsonUseCase,
       _saveJsonUseCase = saveJsonUseCase,
       _editNodeUseCase = editNodeUseCase;

  // CRUD Operations
  Future<void> loadJson(String key) async {
    try {
      setLoading(true);
      final node = await _loadJsonUseCase.execute(key);
       final jsonData = {
        "id": "cat_nature_001",
        "type": "nature",
        "parent_id": null,
        "translations": {
          "en": {
            "name": "Nature",
            "description": "Nature related backgrounds"
          },
          "hi": {
            "name": "प्रकृति",
            "description": "प्रकृति संबंधित पृष्ठभूमि"
          }
        },
        "metadata": {
          "icon": "leaf",
          "color": "0xFF4CAF50"
        },
        "audit": {
          "created_at": "2024-01-02T00:00:00Z",
          "created_by": "system",
          "modified_at": "2024-01-02T00:00:00Z",
          "modified_by": "system",
          "version": 1
        }
      };

      // Create JsonNode using the factory constructor
      _currentNode.value = JsonNode.fromJson(jsonData);
      _clearHistory();
      setSelectedPath(''); // Reset selection to root
    } catch (e) {
      throw JsonOperationException('Failed to load JSON: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> saveJson(String key) async {
    try {
      setLoading(true);
      if (_currentNode.value != null) {
        await _saveJsonUseCase.execute(key, _currentNode.value!);
      }
    } catch (e) {
      throw JsonOperationException('Failed to save JSON: $e');
    } finally {
      setLoading(false);
    }
  }

  void addNode(String path, String key, dynamic value) {
    if (_currentNode.value == null) return;
    
    try {
      final parentNode = _findNodeByPath(_currentNode.value!, path);
      if (parentNode == null) throw JsonOperationException('Invalid path: $path');
      
      if (parentNode.type != JsonNodeType.object && parentNode.type != JsonNodeType.array) {
        throw JsonOperationException('Cannot add child to primitive type');
      }

      final newNode = JsonNode.fromJson(value, key: key, parentPath: path);
      final updatedNode = _addNodeToParent(_currentNode.value!, path, newNode);
      
      _addToHistory(EditAction(
        type: EditActionType.add,
        path: '$path${path.isEmpty ? '' : '.'}$key',
        oldValue: _currentNode.value,
        newValue: updatedNode
      ));
      
      _currentNode.value = updatedNode;
    } catch (e) {
      throw JsonOperationException('Failed to add node: $e');
    }
  }

  void editNode(String path, dynamic newValue) {
    if (_currentNode.value == null) return;
    
    try {
      final oldNode = _currentNode.value!;
      final updatedNode = _editNodeUseCase.execute(oldNode, path, newValue);
      
      _addToHistory(EditAction(
        type: EditActionType.edit,
        path: path,
        oldValue: oldNode,
        newValue: updatedNode
      ));
      
      _currentNode.value = updatedNode;
    } catch (e) {
      throw JsonOperationException('Failed to edit node: $e');
    }
  }

  void deleteNode(String path) {
    if (_currentNode.value == null) return;
    
    try {
      final oldNode = _currentNode.value!;
      final updatedNode = _deleteNodeByPath(oldNode, path);
      
      _addToHistory(EditAction(
        type: EditActionType.delete,
        path: path,
        oldValue: oldNode,
        newValue: updatedNode
      ));
      
      _currentNode.value = updatedNode;
      
      // Reset selection if deleted node was selected
      if (selectedPath.startsWith(path)) {
        final parentPath = path.contains('.')
            ? path.substring(0, path.lastIndexOf('.'))
            : '';
        setSelectedPath(parentPath);
      }
    } catch (e) {
      throw JsonOperationException('Failed to delete node: $e');
    }
  }

  void moveNode(JsonNode sourceNode, JsonNode targetNode) {
    if (_currentNode.value == null) return;
    
    try {
      final oldNode = _currentNode.value!;
      
      // Delete from old location
      var intermediateNode = _deleteNodeByPath(oldNode, sourceNode.path);
      
      // Add to new location
      final updatedNode = _addNodeToParent(
        intermediateNode,
        targetNode.path,
        sourceNode
      );
      
      _addToHistory(EditAction(
        type: EditActionType.edit,
        path: '${sourceNode.path}->${targetNode.path}',
        oldValue: oldNode,
        newValue: updatedNode
      ));
      
      _currentNode.value = updatedNode;
    } catch (e) {
      throw JsonOperationException('Failed to move node: $e');
    }
  }

  // History Management
  void undo() {
    if (!canUndo) return;
    
    final action = _history[_historyIndex.value];
    _currentNode.value = action.oldValue as JsonNode;
    _historyIndex.value--;
  }

  void redo() {
    if (!canRedo) return;
    
    _historyIndex.value++;
    final action = _history[_historyIndex.value];
    _currentNode.value = action.newValue as JsonNode;
  }

  // Bookmark Management
  void toggleBookmark(String path) {
    if (_bookmarks.contains(path)) {
      _bookmarks.remove(path);
    } else {
      _bookmarks.add(path);
    }
  }

  void clearBookmarks() {
    _bookmarks.clear();
  }

  // Navigation
  void setSelectedPath(String path) {
    _selectedPath.value = path;
  }

  // Private Helper Methods
  void _addToHistory(EditAction action) {
    // Remove any redo actions
    if (_historyIndex.value < _history.length - 1) {
      _history.removeRange(_historyIndex.value + 1, _history.length);
    }
    
    // Limit history size to 50 steps as per documentation
    if (_history.length >= 50) {
      _history.removeAt(0);
    }
    
    _history.add(action);
    _historyIndex.value = _history.length - 1;
  }

  void _clearHistory() {
    _history.clear();
    _historyIndex.value = -1;
  }

  JsonNode? _findNodeByPath(JsonNode? root, String path) {
    if (root == null || path.isEmpty) return root;
    
    final parts = path.split('.');
    JsonNode current = root;
    
    for (final part in parts) {
      if (current.type == JsonNodeType.object) {
        final child = current.children.firstWhere(
          (child) => child.key == part,
          orElse: () => throw JsonOperationException('Invalid path: $path'),
        );
        current = child;
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

  JsonNode _addNodeToParent(JsonNode root, String parentPath, JsonNode newNode) {
    if (parentPath.isEmpty) {
      throw JsonOperationException('Cannot add node to root');
    }

    final parent = _findNodeByPath(root, parentPath);
    if (parent == null) {
      throw JsonOperationException('Parent node not found: $parentPath');
    }

    if (parent.type == JsonNodeType.object) {
      if (parent.children.any((child) => child.key == newNode.key)) {
        throw JsonOperationException('Key already exists: ${newNode.key}');
      }
      parent.children.add(newNode);
    } else if (parent.type == JsonNodeType.array) {
      parent.children.add(newNode);
    } else {
      throw JsonOperationException('Cannot add child to primitive type');
    }

    return root;
  }

  JsonNode _deleteNodeByPath(JsonNode root, String path) {
    if (path.isEmpty) {
      throw JsonOperationException('Cannot delete root node');
    }

    final parentPath = path.contains('.')
        ? path.substring(0, path.lastIndexOf('.'))
        : '';
    final nodeName = path.substring(path.lastIndexOf('.') + 1);

    final parent = _findNodeByPath(root, parentPath);
    if (parent == null) {
      throw JsonOperationException('Parent node not found: $parentPath');
    }

    parent.children.removeWhere((child) => 
      parent.type == JsonNodeType.object
          ? child.key == nodeName
          : child.path == path
    );

    return root;
  }
}