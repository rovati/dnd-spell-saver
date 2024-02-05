import 'package:flutter/material.dart';

class SimpleRadioTile extends StatelessWidget {
  final String _label;
  final double _width;

  const SimpleRadioTile(this._label, this._width, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: _width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.grey),
        ),
        child: Center(child: Text(_label)),
      );
}
