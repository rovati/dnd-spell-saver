import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dnd_spell_saver/model/spell.dart';
import 'package:dnd_spell_saver/value/area_of_effect.dart';
import 'package:dnd_spell_saver/value/components.dart';
import 'package:dnd_spell_saver/value/level.dart';
import 'package:dnd_spell_saver/value/saving_throw.dart';
import 'package:dnd_spell_saver/value/school.dart';
import 'package:dnd_spell_saver/value/source.dart';
import 'package:file_saver/file_saver.dart';

class SpellList {
  final List<Spell> spells = [];

  SpellList();

  void addSpell(Spell spell) {
    spells.add(spell);
  }

  SpellList removeSpell(Spell spell) {
    spells.remove(spell);
    return this;
  }

  int get size => spells.length;

  Spell spellAt(int idx) => spells[idx];

  Future<String> exportToCsv() async {
    List<List<dynamic>> csvSpells =
        spells.map((spell) => spell.toCsvRow()).toList();

    String csv = const ListToCsvConverter().convert(csvSpells);
    Uint8List rawCsv = Uint8List.fromList(csv.codeUnits);

    return FileSaver.instance.saveFile(
      name: 'incantesimi',
      bytes: rawCsv,
      ext: '.csv',
      mimeType: MimeType.csv,
    );
  }

  (int, int) loadCsv(String fileData) {
    int parsedSpells = 0;
    List<List<dynamic>> content =
        const CsvToListConverter().convert(fileData, convertEmptyTo: "");
    for (List<dynamic> row in content) {
      Spell? spell = Spell.fromCsvRow(row);
      if (spell != null) {
        spells.add(spell);
        parsedSpells++;
      }
    }

    return (parsedSpells, content.length);
  }

  static SpellList mock() {
    SpellList sl = SpellList();
    Spell s1 = Spell.fromVals(
      'SALTARE',
      'JUMP',
      Source.playerHandbook,
      SpellLevel.first,
      School.transmutation,
      false,
      false,
      'AZIONE',
      'CONTATTO',
      '1 MIN',
      [Component.verbal, Component.somatic, Component.material],
      'Zampa posteriore di una cavalletta',
      AreaOfEffect.none,
      '',
      SavingThrow.none,
      'L\'incantatore tocca una creatura. La distanza coperta dai salti di quella creatura è triplicata finché l\'incantesimo non termina.',
      '',
    );
    Spell s2 = Spell.fromVals(
      'ASSORBIRE ELEMENTI',
      'ABSORB ELEMENTS',
      Source.playerHandbook,
      SpellLevel.first,
      School.abjuration,
      false,
      false,
      'REAZIONE',
      'INCANTATORE',
      'ISTANTANEO',
      [Component.somatic],
      '',
      AreaOfEffect.none,
      '',
      SavingThrow.none,
      "L'incantesimo cattura parte dell'energia in arrivo, riducendone l'effetto su di te e immagazzinandola per il tuo prossimo attacco in mischia. Hai resistenza al tipo di danno innescante fino all'inizio del tuo prossimo turno (...)",
      'Il danno extra aumenta di 1d6 per ogni livello dello slot sopra il 1°',
    );
    Spell s3 = Spell.fromVals(
      'INCUTI PAURA',
      'CAUSE FEAR',
      Source.playerHandbook,
      SpellLevel.first,
      School.necromancy,
      true,
      false,
      'AZIONE',
      '18 M',
      '1 MIN',
      [Component.verbal],
      '',
      AreaOfEffect.none,
      '',
      SavingThrow.dexterity,
      "L'incantatore risveglia la percezione della mortalità in una creatura situata entro gittata e che egli sia in grado di vedere. Un costrutto o un non morto è immune a queto effetto.",
      "L'incantatore può bersagliare una creatura aggiuntiva.",
    );
    sl.addSpell(s1);
    sl.addSpell(s2);
    sl.addSpell(s3);
    return sl;
  }
}
