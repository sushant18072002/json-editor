import 'json_diff.dart';

class ComparisonResult {
  final List<JsonDiff> differences;

  ComparisonResult({required this.differences});
}