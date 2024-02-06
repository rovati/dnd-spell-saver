enum School {
  abjuration('Abiurazione'),
  enchantment('Ammaliamento'),
  divination('Divinazione'),
  evocation('Evocatione'),
  illusion('Illusione'),
  conjuration('Invocazione'),
  necromancy('Necromanzia'),
  transmutation('Transmutazione');

  const School(this.label);
  final String label;

  @override
  String toString() => label.toUpperCase();
}
