
import 'package:json_editor/entities/json/json_node.dart';
import '../repositories/json_repository.dart';

class LoadJsonUseCase {
  final JsonRepository _repository;

  LoadJsonUseCase(this._repository);

  Future<JsonNode?> execute(String key) async {
    return await _repository.loadJson(key);
  }
}