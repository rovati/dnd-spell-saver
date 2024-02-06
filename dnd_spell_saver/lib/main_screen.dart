import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _newCsvAndNavigate(BuildContext context) {
    var spellList = SpellList();
    Navigator.pushNamed(
      context,
      AddSpellPage.routeName,
      arguments: ScreenArguments(
        spellList,
      ),
    );
  }

  void _loadCsvAndNavigate(BuildContext context) {
    var spellList = SpellList();
    spellList.loadCsv();
    Navigator.pushNamed(
      context,
      AddSpellPage.routeName,
      arguments: ScreenArguments(
        spellList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Colors.grey,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 650,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Welcome to Hell!"),
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _newCsvAndNavigate(context);
                                },
                                child: const Text(
                                  "NUOVO CSV",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _loadCsvAndNavigate(context);
                                },
                                child: const Text(
                                  "IMPORTA CSV",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
