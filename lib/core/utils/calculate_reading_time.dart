int clculateReadingTime(String content) {
  final wrodCount = content.split(RegExp(r'\s+')).length;

  final readingTime = wrodCount / 225;

  return readingTime.ceil();
}
