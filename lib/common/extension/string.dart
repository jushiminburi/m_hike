extension StringExtension on String? {
  String get orEmpty => this ?? '';
  bool get isEmptyStr => _skipWhiteSpaces(this);
  bool _skipWhiteSpaces(String? str) {
    if (str == null) {
      return true;
    } else {
     return str.trim().isEmpty;
    }
  }
}
