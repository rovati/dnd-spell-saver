import 'package:flutter/material.dart';

class ValueRadio<T> extends StatefulWidget {
  final List<T> labels;
  final double tileWidth;
  final double valueTileWidth;
  final bool noTile;
  final String hint;
  final bool fill;
  final bool allowMultiple;
  final void Function(T val) selectionCallback;
  final void Function(T val)? deselectionCallback;
  final void Function(String strVal) valueCallback;

  const ValueRadio(
      {super.key,
      required this.labels,
      required this.tileWidth,
      required this.hint,
      required this.selectionCallback,
      required this.valueCallback,
      this.noTile = false,
      this.fill = false,
      this.allowMultiple = false,
      this.deselectionCallback,
      this.valueTileWidth = 0});

  @override
  State<StatefulWidget> createState() => _ValueRadioState<T>();
}

class _ValueRadioState<T> extends State<ValueRadio<T>> {
  T? _selected;
  String? _value;

  Widget _simpleRadioTile(T elem, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selected = elem;
          });
          widget.selectionCallback(elem);
        },
        child: Container(
          width: elem.toString() == "NO" ? 40 : widget.tileWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 2,
                color: _selected == elem
                    ? Theme.of(context).primaryColor
                    : Colors.transparent),
          ),
          child: Center(
            child: Text(
              elem.toString(),
              style: TextStyle(
                  color: _selected == elem
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _valueRadioTile(bool fill) {
    return Container(
      width:
          widget.valueTileWidth == 0 ? widget.tileWidth : widget.valueTileWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            width: 2,
            color: _selected != null &&
                    _selected.toString() != "NO" &&
                    _value != null &&
                    _value!.isNotEmpty
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
                color: _selected != null &&
                        _selected.toString() != "NO" &&
                        _value != null &&
                        _value!.isNotEmpty
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: widget.fill
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: widget.labels
                .map((e) => _simpleRadioTile(e, widget.tileWidth))
                .toList() +
            [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: widget.fill
                    ? Expanded(
                        child: _valueRadioTile(widget.fill),
                      )
                    : _valueRadioTile(widget.fill),
              ),
            ],
      ),
    );
  }
}
