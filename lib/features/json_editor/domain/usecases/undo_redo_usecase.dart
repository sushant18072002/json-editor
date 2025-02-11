import 'package:json_editor/entities/history/edit_action.dart';
import 'package:json_editor/entities/json/json_node.dart';

class UndoRedoUseCase {
  final List<EditAction> _history = [];
  int _currentIndex = -1;

  JsonNode? undo(JsonNode currentNode) {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _applyAction(currentNode, _history[_currentIndex]);
    }
    return null;
  }

  JsonNode? redo(JsonNode currentNode) {
    if (_currentIndex < _history.length - 1) {
      _currentIndex++;
      return _applyAction(currentNode, _history[_currentIndex]);
    }
    return null;
  }

  void addAction(EditAction action) {
    _history.add(action);
    _currentIndex = _history.length - 1;
  }

  JsonNode _applyAction(JsonNode currentNode, EditAction action) {
    return currentNode;
  }
}