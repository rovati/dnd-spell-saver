import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dnd_spell_saver/model/spell.dart';
import 'package:file_saver/file_saver.dart';

class SpellList {
  final List<Spell> spells = [];

  SpellList();

  void addSpell(Spell spell) {
    spells.add(spell);
  }

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

    print(parsedSpells);

    return (parsedSpells, content.length);
  }
}
