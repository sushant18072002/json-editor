import 'dart:convert';

import 'package:json_editor/core/storage/local_storage.dart';
import 'package:json_editor/entities/history/edit_action.dart';

class HistoryRepositoryImpl {
  final LocalStorage _localStorage = LocalStorage();
  final List<EditAction> _history = [];
  int _currentIndex = -1;

  Future<void> addAction(EditAction action) async {
    _history.add(action);
    _currentIndex = _history.length - 1;
    await _localStorage.saveString('history', json.encode(_history));
  }

  Future<EditAction?> undo() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _history[_currentIndex];
    }
    return null;
  }

  Future<EditAction?> redo() async {
    if (_currentIndex < _history.length - 1) {
      _currentIndex++;
      return _history[_currentIndex];
    }
    return null;
  }
}