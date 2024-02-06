enum Duration {
  insta('istantaneo');

  const Duration(this.label);
  final String label;
  static const String hint = "durata";

  @override
  String toString() => label.toUpperCase();
}
