enum Source {
  playerHandbook('phb'),
  xanathar('xanathar'),
  tashasCauldron('tasha'),
  swordCoast('sc'),
  other('altro');

  const Source(this.label);
  final String label;

  @override
  String toString() => label.toUpperCase();
}
