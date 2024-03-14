bool isLink(String text) {
  final RegExp linkRegex = RegExp(
    r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
    caseSensitive: false,
  );
  return linkRegex.hasMatch(text);
}
