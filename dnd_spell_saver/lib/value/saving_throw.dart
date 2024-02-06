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

  @override
  String toString() => label.toUpperCase();
}
