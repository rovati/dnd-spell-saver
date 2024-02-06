import 'package:flutter/material.dart';

class SimpleRadio<T> extends StatefulWidget {
  final List<T> labels;
  final double tileWidth;
  final bool noTile;
  final void Function(T newVal) selectionCallback;

  const SimpleRadio(
      {super.key,
      required this.labels,
      required this.tileWidth,
      required this.selectionCallback,
      this.noTile = false});

  @override
  State<StatefulWidget> createState() => _SimpleRadioState<T>();
}

class _SimpleRadioState<T> extends State<SimpleRadio<T>> {
  T? _selected;

  Widget _radioTile(T elem, double width) {
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: widget.labels
              .map((e) => _radioTile(e, widget.tileWidth))
              .toList()),
    );
  }
}
