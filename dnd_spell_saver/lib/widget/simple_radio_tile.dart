import 'package:flutter/material.dart';

class SimpleRadioTile extends StatefulWidget {
  final String _label;
  final double _width;

  const SimpleRadioTile(this._label, this._width, {super.key});

  @override
  State<StatefulWidget> createState() => _SimpleRadioTileState();
}

class _SimpleRadioTileState extends State<SimpleRadioTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 15),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selected = !_selected;
            });
          },
          child: Container(
            width: widget._width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 2,
                  color: _selected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent),
            ),
            child: Center(
                child: Text(
              widget._label,
              style: TextStyle(
                  color:
                      _selected ? Theme.of(context).primaryColor : Colors.grey),
            )),
          ),
        ),
      );
}
