import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class SimpleRadio<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
  final T? initalValue;
  final double tileWidth;
  final bool noTile;
  final void Function(T newVal) selectionCallback;

  const SimpleRadio({
    super.key,
    required this.title,
    required this.labels,
    this.initalValue,
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

  @override
  void initState() {
    super.initState();
    _selected = widget.initalValue;
  }

  Widget _radioTile(T elem, double width) {
    _selected = widget.initalValue;
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
              color: AppThemeData.containerColor(sel, hover),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                elem.toString(),
                style: TextStyle(
                  color: AppThemeData.textColor(sel, hover),
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
