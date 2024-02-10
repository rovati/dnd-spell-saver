import 'package:flutter/material.dart';

class MultiChoiceRadio<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
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

  Widget _simpleRadioTile(T elem, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          if (_selected.contains(elem)) {
            _selected.remove(elem);
            widget.deselectionCallback(elem);
          } else {
            if (elem.toString() == "NO") {
              for (var e in _selected) {
                widget.deselectionCallback(e);
              }
              _selected.clear();
            }
            _selected.add(elem);
            widget.selectionCallback(elem);
          }

          setState(() {});
        },
        child: Container(
          width: elem.toString() == "NO" ? 40 : widget.tileWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 2,
                color: _selected.contains(elem)
                    ? Theme.of(context).primaryColor
                    : Colors.transparent),
          ),
          child: Center(
            child: Text(
              elem.toString(),
              style: TextStyle(
                  color: _selected.contains(elem)
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
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
                        .map((e) => _simpleRadioTile(e, widget.tileWidth))
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
