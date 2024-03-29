import 'package:dnd_spell_saver/model/spell.dart';
import 'package:flutter/material.dart';

class SpellTile extends StatefulWidget {
  final Spell spell;
  final void Function(Spell) deletionCallback;

  const SpellTile(this.spell, this.deletionCallback, {super.key});

  @override
  State<StatefulWidget> createState() => _SpellTileState();
}

class _SpellTileState extends State<SpellTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
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
                Text(widget.spell.source.label)
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    widget.deletionCallback(widget.spell);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
