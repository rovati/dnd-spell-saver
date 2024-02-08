import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/widget/spell_tile.dart';
import 'package:flutter/material.dart';

class ViewSpellsPage extends StatefulWidget {
  static const routeName = '/views_pells';

  const ViewSpellsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ViewSpellsScreenState();
}

class _ViewSpellsScreenState extends State<ViewSpellsPage> {
  SpellList? _spellList;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    setState(() {
      _spellList = args.spellList;
    });

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 650,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 15),
                child: Text(
                  'Lista degli incantesimi',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 2,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _spellList!.size,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SpellTile(_spellList!.spellAt(index), (val) {
                        setState(() {
                          _spellList = _spellList!.removeSpell(val);
                        });
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'AGGIUNGI INCANTESIMI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AddSpellPage.routeName,
                        arguments: ScreenArguments(
                          _spellList!,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
