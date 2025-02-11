class JsonError {
  final String message;
  final int? lineNumber;

  JsonError({required this.message, this.lineNumber});
}