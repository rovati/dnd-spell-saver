import 'package:dnd_spell_saver/value/area_of_effect.dart';
import 'package:dnd_spell_saver/value/components.dart';
import 'package:dnd_spell_saver/value/level.dart';
import 'package:dnd_spell_saver/value/saving_throw.dart';
import 'package:dnd_spell_saver/value/school.dart';
import 'package:dnd_spell_saver/value/source.dart';

class Spell {
  final String title;
  final String sndTitle;
  final Source source;
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
  final String body;
  final String atHigherLevels;

  Spell(
    this.title,
    this.sndTitle,
    this.source,
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
    this.body,
    this.atHigherLevels,
  );

  List<dynamic> toCsvRow() {
    return [
      title,
      sndTitle,
      source.label,
      level.label,
      school.label,
      concentration,
      ritual,
      castingTime,
      range,
      duration,
      components,
      materialC,
      aoe,
      aoeDim,
      savingThrow,
      body,
      atHigherLevels
    ];
  }
}
