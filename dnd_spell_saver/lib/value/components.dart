enum Component {
  verbal('v'),
  somatic('s'),
  material('m');

  const Component(this.label);
  final String label;
  static const String hint = "materiale";

  @override
  String toString() => label.toUpperCase();
}
