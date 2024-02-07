enum Component {
  verbal('v'),
  somatic('s'),
  material('m');

  const Component(this.label);
  final String label;
  static const String hint = "materiale";

  static List<Component> fromLabels(String labels) {
    Map<String, Component> map = {for (Component v in values) v.label: v};
    labels = labels.replaceAll(RegExp(r'\['), '');
    labels = labels.replaceAll(RegExp(r'\]'), '');
    List<String> vals = labels.split(',');

    List<Component> components = [];
    for (String v in vals) {
      Component? c = map[v.trim()];
      if (c != null) components.add(c);
    }
    return components;
  }

  @override
  String toString() => label.toUpperCase();
}
