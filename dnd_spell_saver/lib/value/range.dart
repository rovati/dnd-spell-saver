enum Range {
  spellcaster('incantatore');

  const Range(this.label);
  final String label;
  static const String hint = "gittata";

  @override
  String toString() => label.toUpperCase();
}
