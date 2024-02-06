import 'package:flutter/material.dart';

class ValueRadioTile extends StatelessWidget {
  final String _hint;
  final double _width;

  const ValueRadioTile(this._hint, this._width, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          width: _width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2, color: Colors.transparent),
          ),
          child: Center(
            child: Text(
              _hint,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
}
