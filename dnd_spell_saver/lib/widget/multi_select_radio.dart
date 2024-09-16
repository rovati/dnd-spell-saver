import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class MultiSelectRadio<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
  final List<T>? initialElems;
  final double tileWidth;
  final void Function(T val) selectionCallback;
  final void Function(T val) deselectionCallback;

  const MultiSelectRadio({
    super.key,
    required this.title,
    required this.labels,
    this.initialElems,
    required this.tileWidth,
    required this.selectionCallback,
    required this.deselectionCallback,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectRadioState<T>();
}

class _MultiSelectRadioState<T> extends State<MultiSelectRadio<T>> {
  late List<T> _selected;
  T? _hovering;

  Widget _radioTile(T elem, double width) {
    bool sel = _selected.contains(elem);
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
              if (_selected.contains(elem)) {
                _selected.remove(elem);
              } else {
                _selected.add(elem);
              }
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
  void initState() {
    super.initState();
    _selected = widget.initialElems ?? [];
  }

  // distirbutes elems over multiple rows depending on the tile size and the number of elements to display
  List<Widget> _rowsBuilder(BoxConstraints constraints) {
    List<Widget> rows = [];
    double minGapBetweenTiles = 10;
    int nbElemsPerRow =
        (constraints.maxWidth / (widget.tileWidth + minGapBetweenTiles))
            .floor();
    int i = 0;
    while (i < widget.labels.length) {
      rows.add(nbElemsPerRow + i < widget.labels.length
          ? Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: widget.labels
                    .sublist(i, nbElemsPerRow + i)
                    .map((e) => _radioTile(e, widget.tileWidth))
                    .toList(),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.labels
                  .sublist(i, widget.labels.length)
                  .map((e) => _radioTile(e, widget.tileWidth))
                  .toList()));
      i += nbElemsPerRow;
    }
    return rows;
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
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _rowsBuilder(constraints));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
