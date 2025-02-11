import 'package:flutter/material.dart';

class JsonSyntaxHighlighter {
  static TextStyle getStyleForToken(String token) {
    if (token.startsWith('"')) {
      return TextStyle(color: Colors.green);
    } else if (token == '{' || token == '}') {
      return TextStyle(color: Colors.blue);
    } else if (token == '[' || token == ']') {
      return TextStyle(color: Colors.orange);
    } else if (token == ':') {
      return TextStyle(color: Colors.purple);
    } else if (token == ',') {
      return TextStyle(color: Colors.red);
    }
    return TextStyle(color: Colors.black);
  }
}