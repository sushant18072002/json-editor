class ErrorHandlers {
  static String handleJsonError(dynamic error) {
    if (error is FormatException) {
      return 'Invalid JSON format: ${error.message}';
    } else {
      return 'An unexpected error occurred: $error';
    }
  }
}