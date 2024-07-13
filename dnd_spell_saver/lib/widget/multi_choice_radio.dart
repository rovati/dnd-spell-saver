import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class MultiChoiceRadio<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
  final List<T> labelsRequiringValue;
  final double tileWidth;
  final double valueTileWidth;
  final String hint;
  final void Function(T val) selectionCallback;
  final void Function(T val) deselectionCallback;
  final void Function(String strVal) valueCallback;
  final List<T> valueBound;

  const MultiChoiceRadio(
      {super.key,
      required this.title,
      required this.labels,
      required this.labelsRequiringValue,
      required this.tileWidth,
      required this.hint,
      required this.selectionCallback,
      required this.deselectionCallback,
      required this.valueCallback,
      this.valueBound = const [],
      this.valueTileWidth = 0});

  @override
  State<StatefulWidget> createState() => _MultiChoiceRadioState<T>();
}

class _MultiChoiceRadioState<T> extends State<MultiChoiceRadio<T>> {
  final List<T> _selected = [];
  String? _value;
  T? _hovering;
  bool? _hoveringValue;

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
              _selected.add(elem);
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

  Widget _valueRadioTile() {
    return Container(
      width: widget.valueTileWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            width: 2,
            color: _isValueTileSelected()
                ? Theme.of(context).primaryColor
                : Colors.transparent),
      ),
      child: SizedBox(
        height: 20,
        child: Center(
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: (text) {
              setState(() {
                _value = text;
              });
              widget.valueCallback(text);
            },
            style: TextStyle(
                color: _isValueTileSelected()
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValueTileSelected() {
    if (_selected.where((e) => e.toString() == "NO").isNotEmpty) {
      return false;
    }

    if (widget.valueBound.isEmpty) {
      return _value != null && _value!.isNotEmpty;
    }

    return _value != null &&
        _value!.isNotEmpty &&
        widget.valueBound.where((e) => _selected.contains(e)).isNotEmpty;
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
                        .toList() +
                    [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: _valueRadioTile(),
                      ),
                    ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
