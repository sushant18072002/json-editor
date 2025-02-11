class JsonDiff {
  final String path;
  final dynamic oldValue;
  final dynamic newValue;

  JsonDiff({required this.path, this.oldValue, this.newValue});
}