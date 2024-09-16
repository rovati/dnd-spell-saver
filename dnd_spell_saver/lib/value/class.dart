enum Class {
  barbarian('barbaro', 'BR'),
  bard('bardo', 'BD'),
  cleric('chierico', 'CL'),
  druid('druido', 'DR'),
  fighter('guerriero', 'FI'),
  monk('monaco', 'MK'),
  paladin('paladino', 'PA'),
  ranger('ranger', 'RA'),
  rogue('ladro', 'RG'),
  sorcerer('stregone', 'SO'),
  warlock('warlock', 'WL'),
  wizard('mago', 'WI');

  const Class(this.label, this.shortHand);
  final String label;
  final String shortHand;
  static const String title = 'CLASSE';

  static List<Class> fromLabels(String labels) {
    Map<String, Class> map = {for (Class v in values) v.label: v};
    labels = labels.replaceAll(RegExp(r'\['), '');
    labels = labels.replaceAll(RegExp(r'\]'), '');
    List<String> vals = labels.split(',');

    List<Class> classes = [];
    for (String v in vals) {
      Class? c = map[v.trim()];
      if (c != null) classes.add(c);
    }
    return classes;
  }

  @override
  String toString() => shortHand;
}
