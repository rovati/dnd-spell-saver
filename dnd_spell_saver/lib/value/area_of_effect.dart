enum AreaOfEffect {
  none('no', false),
  cube('cubo', true),
  circle('cerchio', true),
  sphere('sfera', true),
  cone('cono', true);

  const AreaOfEffect(this.label, this.requriesValue);
  final String label;
  final bool requriesValue;
  static const String hint = 'dim.';
  static const String title = 'AREA';

  static AreaOfEffect? fromLabel(String label) {
    Map<String, AreaOfEffect> map = {for (AreaOfEffect v in values) v.label: v};
    return map[label.toLowerCase()];
  }

  static List<AreaOfEffect> labelsRequiringValue() {
    List<AreaOfEffect> elems = [];
    for (AreaOfEffect aoe in AreaOfEffect.values) {
      if (aoe.requriesValue) {
        elems.add(aoe);
      }
    }
    return elems;
  }

  @override
  String toString() => label.toUpperCase();
}
