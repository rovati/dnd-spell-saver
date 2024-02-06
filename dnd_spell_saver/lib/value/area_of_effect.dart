enum AreaOfEffect {
  none('no'),
  cube('bonus'),
  circle('reazione'),
  sphere('sfera'),
  cone('cono');

  const AreaOfEffect(this.label);
  final String label;
  final String hint = "dim.";

  @override
  String toString() => label.toUpperCase();
}
