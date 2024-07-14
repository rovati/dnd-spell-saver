enum SpellLevel {
  cantrip('cantrip', 'C'),
  first('primo', '1'),
  second('secondo', '2'),
  third('terzo', '3'),
  fourth('quarto', '4'),
  fifth('quinto', '5'),
  sixth('sesto', '6'),
  seventh('settimo', '7');

  const SpellLevel(this.label, this.shortHand);
  final String label;
  final String shortHand;
  static const String title = 'LIVELLO';

  static SpellLevel? fromLabel(String label) {
    Map<String, SpellLevel> map = {for (SpellLevel v in values) v.label: v};
    return map[label.toLowerCase()];
  }

  @override
  String toString() => shortHand;
}
