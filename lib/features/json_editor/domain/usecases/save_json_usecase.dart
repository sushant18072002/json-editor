import 'package:json_editor/entities/json/json_node.dart';
import '../repositories/json_repository.dart';

class SaveJsonUseCase {
  final JsonRepository _repository;

  SaveJsonUseCase(this._repository);

  Future<void> execute(String key, JsonNode jsonNode) async {
    await _repository.saveJson(key, jsonNode);
  }
}