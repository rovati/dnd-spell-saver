enum School {
  abjuration('Abiurazione', 'AB'),
  enchantment('Ammaliamento', 'AM'),
  divination('Divinazione', 'DI'),
  evocation('Evocazione', 'EV'),
  illusion('Illusione', 'IL'),
  conjuration('Invocazione', 'IN'),
  necromancy('Necromanzia', 'NE'),
  transmutation('Transmutazione', 'TR');

  const School(this.label, this.shortHand);
  final String label;
  final String shortHand;
  static const String title = 'SCUOLA';

  static School? fromLabel(String label) {
    Map<String, School> map = {for (School v in values) v.label: v};
    String school =
        "${label[0].toUpperCase()}${label.substring(1).toLowerCase()}";
    return map[school];
  }

  @override
  String toString() => shortHand;
}
