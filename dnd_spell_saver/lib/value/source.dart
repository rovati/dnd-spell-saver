enum Source {
  playerHandbook('phb'),
  xanathar('xanathar'),
  tashasCauldron('tasha'),
  swordCoast('sc'),
  other('altro');

  const Source(this.label);
  final String label;

  static Source? fromLabel(String label) {
    Map<String, Source> map = {for (Source v in values) v.label: v};
    return map[label.toLowerCase()];
  }

  @override
  String toString() => label.toUpperCase();
}
