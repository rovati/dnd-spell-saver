enum CastingTime {
  action('azione'),
  bonusAction('bonus'),
  reaction('reazione');

  const CastingTime(this.label);
  final String label;
  final String hint = "tempo";

  @override
  String toString() => label.toUpperCase();
}
