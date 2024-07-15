import 'package:dnd_spell_saver/value/area_of_effect.dart';
import 'package:dnd_spell_saver/value/components.dart';
import 'package:dnd_spell_saver/value/level.dart';
import 'package:dnd_spell_saver/value/saving_throw.dart';
import 'package:dnd_spell_saver/value/school.dart';
import 'package:dnd_spell_saver/value/source.dart';

class Spell {
  static const concentrationTitle = 'CONCENTRATIONE';
  static const ritualTitle = "RITUALE";

  String title = '';
  String sndTitle = '';
  Source? source;
  SpellLevel? level;
  School? school;
  bool concentration = false;
  bool ritual = false;
  String? castingTime;
  String? range;
  String? duration;
  List<Component> components = [];
  String? materialC;
  AreaOfEffect? aoe;
  String? aoeDim;
  SavingThrow? savingThrow;
  String body = '';
  String atHigherLevels = '';

  Spell();

  Spell.fromVals(
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

    return Spell.fromVals(
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
      source!.label,
      level!.label,
      school!.label,
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

  (bool, List<String>) validate() {
    List<String> errorFields = [];

    if (title.isEmpty) {
      errorFields.add('\'TITOLO\' è vuoto.');
    }
    if (source == null) {
      errorFields.add('\'FONTE\' non è selezionato.');
    }
    if (level == null) {
      errorFields.add('\'LIVELLO\' non è selezionato.');
    }
    if (school == null) {
      errorFields.add('\'SCUOLA\' non è selezionato.');
    }
    if (castingTime == null) {
      errorFields.add('\'TEMPO DI LANCIO\' non è selezionato.');
    } else if (castingTime!.isEmpty) {
      errorFields.add(
          '\'TEMPO DI LANCIO\' ha un valore non default, ma il valore è vuoto.');
    }
    if (range == null) {
      errorFields.add('\'GITTATA\' non è selezionato.');
    } else if (range!.isEmpty) {
      errorFields
          .add('\'GITTATA\' ha un valore non default, ma il valore è vuoto.');
    }
    if (duration == null) {
      errorFields.add('\'DURATA\' non è selezionato.');
    } else if (duration!.isEmpty) {
      errorFields
          .add('\'DURATA\' ha un valore non default, ma il valore è vuoto.');
    }
    if (components.contains(Component.material) &&
        (materialC == null || materialC!.isEmpty)) {
      errorFields
          .add('\'COMPONENTI\' contiene Materiale ma non specifica quale.');
    }
    if (aoe == null) {
      errorFields.add('\'AREA\' non è selezionato.');
    } else if (aoe != AreaOfEffect.none &&
        (aoeDim == null || aoeDim!.isEmpty)) {
      errorFields
          .add('\'AREA\' ha un tipo di area ma non specifica la dimensione.');
    }
    if (savingThrow == null) {
      errorFields.add('\'TIRO SLAVEZZA\' non è selezionato.');
    }
    if (body.isEmpty) {
      errorFields.add('\'DESCRIZIONE\' è vuoto.');
    }

    return (errorFields.isEmpty, errorFields);
  }
}
