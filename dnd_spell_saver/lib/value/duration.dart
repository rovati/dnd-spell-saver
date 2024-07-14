enum Duration {
  insta('istantaneo');

  const Duration(this.label);
  final String label;
  static const String hint = 'durata';
  static const String title = 'DURATION';

  @override
  String toString() => label.toUpperCase();
}
