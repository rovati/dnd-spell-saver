import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:dnd_spell_saver/model/spell.dart';
import 'package:file_saver/file_saver.dart';

class SpellList {
  final List<Spell> spells = [];

  SpellList();

  void loadCsv() {
    throw UnimplementedError("Not implemented yet.");
  }

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
}
