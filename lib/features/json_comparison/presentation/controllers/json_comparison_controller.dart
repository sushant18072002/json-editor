import 'package:get/get.dart';
import 'package:json_editor/entities/comparison/comparison_result.dart';
import 'package:json_editor/entities/json/json_node.dart';

class JsonComparisonController extends GetxController {
  final Rx<JsonNode?> _leftJsonNode = Rx<JsonNode?>(null);
  final Rx<JsonNode?> _rightJsonNode = Rx<JsonNode?>(null);
  final Rx<ComparisonResult?> _comparisonResult = Rx<ComparisonResult?>(null);

  JsonNode? get leftJsonNode => _leftJsonNode.value;
  JsonNode? get rightJsonNode => _rightJsonNode.value;
  ComparisonResult? get comparisonResult => _comparisonResult.value;

  void setLeftJson(JsonNode jsonNode) {
    _leftJsonNode.value = jsonNode;
  }

  void setRightJson(JsonNode jsonNode) {
    _rightJsonNode.value = jsonNode;
  }

  void compareJson() {
    if (_leftJsonNode.value != null && _rightJsonNode.value != null) {
      _comparisonResult.value = ComparisonResult(differences: []);
    }
  }
}