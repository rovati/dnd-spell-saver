import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/widget/centered_scrollable.dart';
import 'package:dnd_spell_saver/widget/styled_dropzone.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = "/";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Color.fromARGB(255, 122, 122, 122),
        ),
        child: CenteredScrollable(
          padding: 20,
          child: SizedBox(
            width: 650,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "DnD Spell Saver",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text('Per cominciare, crea un nuovo csv:'),
                const SizedBox(
                  height: 30,
                ),
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
                  height: 100,
                ),
                const Text('Oppure, comincia da un csv esistente:'),
                const SizedBox(
                  height: 30,
                ),
                const StyledDropzone(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
