class JsonPathUtils {
  static String getPath(List<String> keys) {
    return keys.join('.');
  }

  static List<String> splitPath(String path) {
    return path.split('.');
  }
}