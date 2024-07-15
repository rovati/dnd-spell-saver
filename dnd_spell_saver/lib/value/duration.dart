enum Duration {
  insta('istantaneo');

  const Duration(this.label);
  final String label;
  static const String hint = 'durata';
  static const String title = 'DURATION';

  static Duration? fromString(String? v) {
    if (v == null) {
      return null;
    }

    for (Duration d in values) {
      if (d.label == v.toLowerCase()) {
        return d;
      }
    }
    return null;
  }

  @override
  String toString() => label.toUpperCase();
}
