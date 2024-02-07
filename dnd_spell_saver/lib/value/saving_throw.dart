enum SavingThrow {
  none('no'),
  force('for'),
  dexterity('des'),
  constitution('cos'),
  intelligence('int'),
  wisdom('sag'),
  charisma('car');

  const SavingThrow(this.label);
  final String label;

  static SavingThrow? fromLabel(String label) {
    Map<String, SavingThrow> map = {for (SavingThrow v in values) v.label: v};
    return map[label.toLowerCase()];
  }

  @override
  String toString() => label.toUpperCase();
}
