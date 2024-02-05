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
}
