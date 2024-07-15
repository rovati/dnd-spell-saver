import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:dnd_spell_saver/widget/centered_scrollable.dart';
import 'package:dnd_spell_saver/widget/spell_list_header.dart';
import 'package:dnd_spell_saver/widget/spell_tile.dart';
import 'package:flutter/material.dart';

class ViewSpellsPage extends StatefulWidget {
  static const routeName = '/view_spells';

  const ViewSpellsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ViewSpellsScreenState();
}

class _ViewSpellsScreenState extends State<ViewSpellsPage> {
  SpellList? _spellList;

  @override
  Widget build(BuildContext context) {
    /*
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    setState(() {
      _spellList = args.spellList;
    });*/
    _spellList = SpellList.mock();

    return Scaffold(
      backgroundColor: AppThemeData.lightColorScheme.surfaceContainerHighest,
      body: CenteredScrollable(
        horizontalOnly: true,
        padding: 10,
        child: Card(
          elevation: 7,
          surfaceTintColor: AppThemeData.lightColorScheme.surface,
          child: SizedBox(
            width: 710,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SpellListHeader('Lista degli incantesimi', _spellList!),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _spellList == null ? 0 : _spellList!.size,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SpellTile(_spellList!.spellAt(index), (val) {
                            setState(() {
                              _spellList = _spellList!.removeSpell(val);
                            });
                          }, (val) {
                            Navigator.pushNamed(
                              context,
                              AddSpellPage.routeName,
                              arguments: ScreenArguments.withSpell(
                                _spellList!,
                                _spellList!.spellAt(index),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
