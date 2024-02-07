enum AreaOfEffect {
  none('no'),
  cube('cubo'),
  circle('cerchio'),
  sphere('sfera'),
  cone('cono');

  const AreaOfEffect(this.label);
  final String label;
  static const String hint = "dim.";

  static AreaOfEffect? fromLabel(String label) {
    Map<String, AreaOfEffect> map = {for (AreaOfEffect v in values) v.label: v};
    return map[label.toLowerCase()];
  }

  @override
  String toString() => label.toUpperCase();
}
