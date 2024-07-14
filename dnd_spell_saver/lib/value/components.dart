enum Component {
  verbal('v', false),
  somatic('s', false),
  material('m', true);

  const Component(this.label, this.requiresValue);
  final String label;
  final bool requiresValue;
  static const String hint = "materiale";
  static const String title = "COMPONENTI";

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

  static List<Component> labelsRequiringValue() {
    List<Component> components = [];
    for (Component c in Component.values) {
      if (c.requiresValue) {
        components.add(c);
      }
    }
    return components;
  }

  @override
  String toString() => label.toUpperCase();
}
