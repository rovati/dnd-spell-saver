import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class SimpleRadio<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
  final double tileWidth;
  final bool noTile;
  final void Function(T newVal) selectionCallback;

  const SimpleRadio({
    super.key,
    required this.title,
    required this.labels,
    required this.tileWidth,
    required this.selectionCallback,
    this.noTile = false,
  });

  @override
  State<StatefulWidget> createState() => _SimpleRadioState<T>();
}

class _SimpleRadioState<T> extends State<SimpleRadio<T>> {
  T? _selected;
  T? _hovering;

  Color _containerColor(bool selected, bool hovering) {
    if (selected) {
      return AppThemeData.lightColorScheme.primary;
    } else {
      if (hovering) {
        return AppThemeData.lightColorScheme.primaryContainer;
      } else {
        return AppThemeData.lightColorScheme.background;
      }
    }
  }

  Color _textColor(bool selected, bool hovering) {
    if (selected) {
      return AppThemeData.lightColorScheme.onPrimary;
    } else {
      if (hovering) {
        return AppThemeData.lightColorScheme.onPrimaryContainer;
      } else {
        return AppThemeData.lightColorScheme.onBackground;
      }
    }
  }

  Widget _radioTile(T elem, double width) {
    bool sel = _selected != null && _selected == elem;
    bool hover = _hovering != null && _hovering == elem;

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (event) {
          setState(() {
            _hovering = elem;
          });
        },
        onExit: (event) => (setState(() {
          _hovering = null;
        })),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selected = elem;
            });
            widget.selectionCallback(elem);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: elem.toString() == "NO" ? 40 : width,
            height: 25,
            decoration: BoxDecoration(
              color: _containerColor(sel, hover),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                elem.toString(),
                style: TextStyle(
                  color: _textColor(sel, hover),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 125,
              child: Text(
                '${widget.title}:',
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: widget.labels
                      .map((e) => _radioTile(e, widget.tileWidth))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
