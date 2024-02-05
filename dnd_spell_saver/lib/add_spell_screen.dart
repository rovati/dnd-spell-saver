import 'package:dnd_spell_saver/widget/simple_radio_tile.dart';
import 'package:dnd_spell_saver/widget/value_radio_button.dart';
import 'package:flutter/material.dart';

import 'value/level.dart';
import 'value/school.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 500,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "TITOLO",
                ),
                controller: _titleController,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 500,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "TITOLO INGLESE",
                ),
                controller: _enTitleController,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text(
                      "LIVELLO:",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  DropdownMenu<SpellLevel>(
                    controller: _spellLevelController,
                    requestFocusOnTap: true,
                    onSelected: (SpellLevel? level) {
                      setState(() {
                        _selectedSpellLevel = level;
                      });
                    },
                    dropdownMenuEntries: SpellLevel.values
                        .map<DropdownMenuEntry<SpellLevel>>((SpellLevel level) {
                      return DropdownMenuEntry<SpellLevel>(
                        value: level,
                        label: level.label,
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 100,
                    child: Text(
                      "SCUOLA:",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  DropdownMenu<School>(
                    controller: _schoolController,
                    requestFocusOnTap: true,
                    onSelected: (School? school) {
                      setState(() {
                        _selectedSchool = school;
                      });
                    },
                    dropdownMenuEntries: School.values
                        .map<DropdownMenuEntry<School>>((School school) {
                      return DropdownMenuEntry<School>(
                        value: school,
                        label: school.label,
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 150,
                    child: Text(
                      "CONENTRAZIONE:",
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
                    width: 150,
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      "CASTING TIME:",
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 150,
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 150,
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 150,
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 150,
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
                        SimpleRadioTile("NO", 50),
                        SimpleRadioTile("CUBO", 70),
                        SimpleRadioTile("CERCHIO", 70),
                        SimpleRadioTile("SFERA", 70),
                        SimpleRadioTile("CONO", 70),
                        ValueRadioTile("dimensione", 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 150,
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
                        SimpleRadioTile("NO", 50),
                        SimpleRadioTile("FOR", 50),
                        SimpleRadioTile("DES", 50),
                        SimpleRadioTile("COS", 50),
                        SimpleRadioTile("INT", 50),
                        SimpleRadioTile("SAG", 50),
                        SimpleRadioTile("CAR", 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Center(
                child: Text("AI LIVELLI PIÙ ALTI"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("AGGIUNGI"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("ESPORTA CSV"),
            ),
          ],
        ),
      ),
    );
  }
}
