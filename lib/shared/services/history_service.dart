import 'package:json_editor/entities/history/edit_action.dart';

class HistoryService {
  final List<EditAction> _history = [];
  int _currentIndex = -1;

  void addAction(EditAction action) {
    _history.add(action);
    _currentIndex = _history.length - 1;
  }

  EditAction? undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _history[_currentIndex];
    }
    return null;
  }

  EditAction? redo() {
    if (_currentIndex < _history.length - 1) {
      _currentIndex++;
      return _history[_currentIndex];
    }
    return null;
  }
}