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
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (event) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (event) => (setState(() {
        _hovering = false;
      })),
      child: Card(
        elevation: 2,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppThemeData.cardColor(_hovering),
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
                    widget.spell.sndTitle != ''
                        ? Text(widget.spell.sndTitle)
                        : const SizedBox(),
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
        ),
      ),
    );
  }
}
