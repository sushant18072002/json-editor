import 'dart:convert';

class JsonNode {
  dynamic data;
  String? key;
  String path;
  List<JsonNode> children;
  JsonNodeType type;

  JsonNode({
    required this.data,
    this.key,
    this.path = '',
    List<JsonNode>? children,
    JsonNodeType? type,
  }) : children = children ?? [],
       type = type ?? _determineType(data);

  static JsonNodeType _determineType(dynamic data) {
    if (data == null) return JsonNodeType.null_;
    if (data is String) return JsonNodeType.string;
    if (data is num) return JsonNodeType.number;
    if (data is bool) return JsonNodeType.boolean;
    if (data is Map) return JsonNodeType.object;
    if (data is List) return JsonNodeType.array;
    return JsonNodeType.unknown;
  }

  factory JsonNode.fromJson(dynamic json, {String? key, String parentPath = ''}) {
    final path = parentPath.isEmpty ? (key ?? '') : '$parentPath.${key ?? ''}';
    
    if (json is Map) {
      final children = json.entries.map((entry) =>
        JsonNode.fromJson(entry.value, key: entry.key, parentPath: path)
      ).toList();
      return JsonNode(data: json, key: key, path: path, children: children, type: JsonNodeType.object);
    }
    
    if (json is List) {
      final children = json.asMap().entries.map((entry) =>
        JsonNode.fromJson(entry.value, key: entry.key.toString(), parentPath: path)
      ).toList();
      return JsonNode(data: json, key: key, path: path, children: children, type: JsonNodeType.array);
    }
    
    return JsonNode(data: json, key: key, path: path);
  }

  dynamic toJson() { 
    if (type == JsonNodeType.object) {
      return Map.fromEntries(
        children.map((child) => MapEntry(child.key!, child.toJson()))
      );
    }
    if (type == JsonNodeType.array) {
      return children.map((child) => child.toJson()).toList();
    }
    return data;
  }
}

enum JsonNodeType {
  object,
  array,
  string,
  number,
  boolean,
  null_,
  unknown
}