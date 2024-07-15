import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class SpellListHeader extends StatelessWidget {
  final String headerText;
  final SpellList spellList;

  const SpellListHeader(this.headerText, this.spellList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppThemeData.lightColorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: Text(
                  headerText,
                  style: TextStyle(
                    fontSize: 32,
                    color: AppThemeData.lightColorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 270,
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'AGGIUNGI INCANTESIMI',
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddSpellPage.routeName,
                    arguments: ScreenArguments(
                      spellList,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
