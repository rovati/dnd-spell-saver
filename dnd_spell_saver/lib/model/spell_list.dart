import 'package:dnd_spell_saver/model/spell.dart';

class SpellList {
  final List<Spell> spells = [];

  SpellList();

  void loadCsv() {
    throw UnimplementedError("Not implemented yet.");
  }

  void addSpell(Spell spell) {
    spells.add(spell);
  }

  void exportToCsv() {
    throw UnimplementedError("Not implemented yet.");
  }
}
