enum Component {
  verbal('v'),
  somatic('s'),
  material('m');

  const Component(this.label);
  final String label;
  final String hint = "materiale";

  @override
  String toString() => label.toUpperCase();
}
