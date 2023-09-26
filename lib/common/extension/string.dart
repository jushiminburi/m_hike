extension StringExtension on String? {
  String get orEmpty => this ?? '';
  bool get isEmptyStr => orEmpty.isEmpty;
}
