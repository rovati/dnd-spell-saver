import 'package:dnd_spell_saver/model/spell.dart';
import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class SpellTile extends StatefulWidget {
  final Spell spell;
  final void Function(Spell) deletionCallback;
  final void Function(Spell) editCallback;

  const SpellTile(this.spell, this.deletionCallback, this.editCallback,
      {super.key});

  @override
  State<StatefulWidget> createState() => _SpellTileState();
}

class _SpellTileState extends State<SpellTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.spell.title,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(widget.spell.sndTitle),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                onPressed: () {
                  widget.deletionCallback(widget.spell);
                },
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: AppThemeData.lightColorScheme.primary,
                ),
                onPressed: () {
                  widget.editCallback(widget.spell);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
