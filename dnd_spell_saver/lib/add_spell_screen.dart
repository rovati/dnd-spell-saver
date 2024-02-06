import 'package:dnd_spell_saver/widget/simple_radio_tile.dart';
import 'package:dnd_spell_saver/widget/value_radio_button.dart';
import 'package:flutter/material.dart';

import 'value/level.dart';
import 'value/school.dart';

class AddSpellPage extends StatefulWidget {
  const AddSpellPage({super.key});

  @override
  State<AddSpellPage> createState() => _AddSpellPageState();
}

class _AddSpellPageState extends State<AddSpellPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _enTitleController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _spellLevelController = TextEditingController();

  School? _selectedSchool;
  SpellLevel? _selectedSpellLevel;
  bool _concentration = false;
  bool _ritual = false;
  String? _castingTime;
  String? _range;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Colors.grey,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // titolo
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: 500,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "TITOLO",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    controller: _titleController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ),
              // titolo inglese
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: 300,
                  height: 35,
                  child: Center(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "TITOLO INGLESE",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      controller: _enTitleController,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // livello scuola
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 105,
                        child: Text(
                          "LIVELLO:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: DropdownMenu<SpellLevel>(
                          width: 200,
                          hintText: "SELEZIONA",
                          controller: _spellLevelController,
                          requestFocusOnTap: true,
                          onSelected: (SpellLevel? level) {
                            setState(() {
                              _selectedSpellLevel = level;
                            });
                          },
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: InputBorder.none,
                          ),
                          textStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          dropdownMenuEntries: SpellLevel.values
                              .map<DropdownMenuEntry<SpellLevel>>(
                                  (SpellLevel level) {
                            return DropdownMenuEntry<SpellLevel>(
                              value: level,
                              label: level.label,
                              style: MenuItemButton.styleFrom(
                                  foregroundColor: level == _selectedSpellLevel
                                      ? Colors.white
                                      : Colors.grey,
                                  backgroundColor: Colors.white),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        width: 105,
                        child: Text(
                          "SCUOLA:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: DropdownMenu<School>(
                          width: 200,
                          hintText: "SELEZIONA",
                          controller: _schoolController,
                          requestFocusOnTap: true,
                          onSelected: (School? school) {
                            setState(() {
                              _selectedSchool = school;
                            });
                          },
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: InputBorder.none,
                          ),
                          textStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          dropdownMenuEntries: School.values
                              .map<DropdownMenuEntry<School>>((School school) {
                            return DropdownMenuEntry<School>(
                              value: school,
                              label: school.label,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // concentrazione, rituale
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text(
                          "CONCENTRAZIONE:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Checkbox(
                        value: _concentration,
                        onChanged: (val) {
                          setState(() {
                            _concentration = val!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 130,
                        child: Text(
                          "RITUALE:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Checkbox(
                        value: _ritual,
                        onChanged: (val) {
                          setState(() {
                            _ritual = val!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // tempo lancio
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "TEMPO DI LANCIO:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SimpleRadioTile("AZIONE", 90),
                            SimpleRadioTile("BONUS", 90),
                            SimpleRadioTile("REAZIONE", 90),
                            ValueRadioTile("tempo", 90),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // gittata
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "GITTATA:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SimpleRadioTile("INCANTATORE", 150),
                            ValueRadioTile("gittata", 150),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // durata
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "DURATA:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SimpleRadioTile("ISTANTANEO", 150),
                            ValueRadioTile("durata", 150),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // componenti
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "COMPONENTI:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SimpleRadioTile("V", 30),
                            SimpleRadioTile("S", 30),
                            SimpleRadioTile("M", 30),
                            Expanded(
                              child: ValueRadioTile("materiale", 300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // area
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "AREA:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SimpleRadioTile("NO", 40),
                            SimpleRadioTile("CUBO", 70),
                            SimpleRadioTile("CERCHIO", 70),
                            SimpleRadioTile("SFERA", 70),
                            SimpleRadioTile("CONO", 70),
                            ValueRadioTile("dim.", 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ts
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "TIRO SLAVEZZA:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SimpleRadioTile("NO", 40),
                            SimpleRadioTile("FOR", 60),
                            SimpleRadioTile("DES", 60),
                            SimpleRadioTile("COS", 60),
                            SimpleRadioTile("INT", 60),
                            SimpleRadioTile("SAG", 60),
                            SimpleRadioTile("CAR", 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // corpo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Corpo",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Center(
                    child: Text("AI LIVELLI PIÙ ALTI"),
                  ),
                ),
              ),
              // livelli alti
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    decoration: InputDecoration(
                      hintText: "Ai livelli più alti...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // aggiungi
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "AGGIUNGI",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // esporta
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "ESPORTA CSV",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
