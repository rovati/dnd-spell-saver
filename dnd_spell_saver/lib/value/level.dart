enum SpellLevel {
  cantrip('cantrip'),
  first('primo'),
  second('secondo'),
  third('terzo'),
  fourth('quarto'),
  fifth('quinto'),
  sixth('sesto'),
  seventh('settimo');

  const SpellLevel(this.label);
  final String label;

  static SpellLevel? fromLabel(String label) {
    Map<String, SpellLevel> map = {for (SpellLevel v in values) v.label: v};
    return map[label.toLowerCase()];
  }

  @override
  String toString() => label.toUpperCase();
}
