enum CastingTime {
  action('azione'),
  bonusAction('bonus'),
  reaction('reazione');

  const CastingTime(this.label);
  final String label;
  static const String hint = "tempo";
  static const String title = "TEMPO DI LANCIO";

  static CastingTime? fromString(String? v) {
    if (v == null) {
      return null;
    }

    for (CastingTime ct in values) {
      if (ct.label == v.toLowerCase()) {
        return ct;
      }
    }
    return null;
  }

  @override
  String toString() => label.toUpperCase();
}
