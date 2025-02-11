import 'package:json_editor/entities/json/json_node.dart';

class AddNodeUseCase {
  JsonNode execute(JsonNode parentNode, String key, dynamic value) {
    if (parentNode.data is Map) {
      parentNode.data[key] = value;
    } else if (parentNode.data is List) {
      parentNode.data.add(value);
    }
    return parentNode;
  }
}