enum Range {
  spellcaster('incantatore'),
  touch('contatto');

  const Range(this.label);
  final String label;
  static const String hint = "gittata";
  static const String title = "GITTATA";

  static Range? fromString(String? v) {
    if (v == null) {
      return null;
    }

    for (Range r in values) {
      if (r.label == v.toLowerCase()) {
        return r;
      }
    }
    return null;
  }

  @override
  String toString() => label.toUpperCase();
}
