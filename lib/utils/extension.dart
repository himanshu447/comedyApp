extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

bool equalsIgnoreCase(String string1, String string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

extension StringExtensions on String {
  bool containsIgnoreCase(String secondString) => this.toLowerCase().contains(secondString.toLowerCase());
}