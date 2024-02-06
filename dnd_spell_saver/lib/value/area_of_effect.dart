enum AreaOfEffect {
  none('no'),
  cube('cubo'),
  circle('cerchio'),
  sphere('sfera'),
  cone('cono');

  const AreaOfEffect(this.label);
  final String label;
  static const String hint = "dim.";

  @override
  String toString() => label.toUpperCase();
}
