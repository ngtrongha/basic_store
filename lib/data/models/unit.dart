class Unit {
  int id = 0;

  /// Display name (can include Vietnamese diacritics), e.g. "Thùng".
  String name = '';

  /// Normalized key (no diacritics), e.g. "thung".
  String key = '';

  bool isActive = true;
  DateTime createdAt = DateTime.now();
}
