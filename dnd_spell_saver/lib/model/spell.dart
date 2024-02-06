import 'package:dnd_spell_saver/value/area_of_effect.dart';
import 'package:dnd_spell_saver/value/components.dart';
import 'package:dnd_spell_saver/value/level.dart';
import 'package:dnd_spell_saver/value/saving_throw.dart';
import 'package:dnd_spell_saver/value/school.dart';

class Spell {
  final String title;
  final String sndTitle;
  final SpellLevel level;
  final School school;
  final bool concentration;
  final bool ritual;
  final String castingTime;
  final String range;
  final String duration;
  final List<Component> components;
  final String materialC;
  final AreaOfEffect aoe;
  final String aoeDim;
  final SavingThrow savingThrow;

  Spell(
    this.title,
    this.sndTitle,
    this.level,
    this.school,
    this.concentration,
    this.ritual,
    this.castingTime,
    this.range,
    this.duration,
    this.components,
    this.materialC,
    this.aoe,
    this.aoeDim,
    this.savingThrow,
  );
}
