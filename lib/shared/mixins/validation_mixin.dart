import 'dart:convert';

mixin ValidationMixin {
  bool isValidJson(String jsonString) {
    try {
      json.decode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}