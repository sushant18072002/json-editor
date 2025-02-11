import 'package:json_editor/entities/json/json_node.dart';

class EditNodeUseCase {
  JsonNode execute(JsonNode node, String path, dynamic newValue) {
    final pathParts = path.split('.');
    return _updateNodeAtPath(node, pathParts, newValue);
  }

  JsonNode _updateNodeAtPath(JsonNode node, List<String> pathParts, dynamic newValue) {
    if (pathParts.isEmpty) {
      return JsonNode(data: newValue, key: node.key, path: node.path);
    }

    final currentKey = pathParts.first;
    final remainingPath = pathParts.sublist(1);

    if (node.type == JsonNodeType.object) {
      final Map<String, dynamic> newData = Map.from(node.data as Map);
      if (remainingPath.isEmpty) {
        newData[currentKey] = newValue;
      } else {
        final childNode = node.children.firstWhere((child) => child.key == currentKey);
        final updatedChild = _updateNodeAtPath(childNode, remainingPath, newValue);
        newData[currentKey] = updatedChild.data;
      }
      return JsonNode(data: newData, key: node.key, path: node.path);
    }

    if (node.type == JsonNodeType.array) {
      final List<dynamic> newData = List.from(node.data as List);
      final index = int.parse(currentKey);
      if (remainingPath.isEmpty) {
        newData[index] = newValue;
      } else {
        final childNode = node.children[index];
        final updatedChild = _updateNodeAtPath(childNode, remainingPath, newValue);
        newData[index] = updatedChild.data;
      }
      return JsonNode(data: newData, key: node.key, path: node.path);
    }

    throw Exception('Invalid path: $pathParts');
  }
}