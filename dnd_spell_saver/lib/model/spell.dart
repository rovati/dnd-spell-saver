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

  static Spell? fromCsvRow(List<dynamic> row) {
    if (row.length != 17) {
      return null;
    }

    String title = row[0];
    if (title.isEmpty) {
      return null;
    }
    String sndTitle = row[1];
    if (sndTitle.isEmpty) {
      return null;
    }
    Source? source = Source.fromLabel(row[2]);
    if (source == null) {
      return null;
    }
    SpellLevel? level = SpellLevel.fromLabel(row[3]);
    if (level == null) {
      return null;
    }
    School? school = School.fromLabel(row[4]);
    if (school == null) {
      return null;
    }
    bool concentration = row[5] == 'true';
    bool ritual = row[6] == 'true';
    String castingTime = row[7];
    if (castingTime.isEmpty) {
      return null;
    }
    String range = row[8];
    if (range.isEmpty) {
      return null;
    }
    String duration = row[9];
    if (duration.isEmpty) {
      return null;
    }
    List<Component> components = Component.fromLabels(row[10]);
    String material = row[11];
    if (components.contains(Component.material) && material.isEmpty) {
      return null;
    }
    AreaOfEffect? aoe = AreaOfEffect.fromLabel(row[12]);
    if (aoe == null) {
      return null;
    }
    String aoeDim = row[13];
    if (aoeDim.isEmpty && aoe != AreaOfEffect.none) {
      return null;
    }
    SavingThrow? savingThrow = SavingThrow.fromLabel(row[14]);
    if (savingThrow == null) {
      return null;
    }
    String body = row[15];
    if (body.isEmpty) {
      return null;
    }
    String higherLevels = row[16];

    return Spell(
        title,
        sndTitle,
        source,
        level,
        school,
        concentration,
        ritual,
        castingTime,
        range,
        duration,
        components,
        material,
        aoe,
        aoeDim,
        savingThrow,
        body,
        higherLevels);
  }

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
