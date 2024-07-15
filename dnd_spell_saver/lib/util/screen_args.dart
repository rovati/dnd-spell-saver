import 'package:dnd_spell_saver/model/spell.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';

class ScreenArguments {
  final SpellList spellList;
  Spell? spell;

  ScreenArguments(this.spellList);

  ScreenArguments.withSpell(this.spellList, this.spell);
}
