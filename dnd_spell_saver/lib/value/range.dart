enum Range {
  spellcaster('incantatore'),
  touch('contatto');

  const Range(this.label);
  final String label;
  static const String hint = "gittata";
  static const String title = "GITTATA";

  @override
  String toString() => label.toUpperCase();
}
