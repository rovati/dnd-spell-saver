enum School {
  abjuration('Abiurazione'),
  enchantment('Ammaliamento'),
  divination('Divinazione'),
  evocation('Evocazione'),
  illusion('Illusione'),
  conjuration('Invocazione'),
  necromancy('Necromanzia'),
  transmutation('Transmutazione');

  const School(this.label);
  final String label;

  static School? fromLabel(String label) {
    Map<String, School> map = {for (School v in values) v.label: v};
    String school =
        "${label[0].toUpperCase()}${label.substring(1).toLowerCase()}";
    return map[school];
  }

  @override
  String toString() => label.toUpperCase();
}
