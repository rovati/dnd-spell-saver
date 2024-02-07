import 'package:flutter/material.dart';

class DropzoneCorner extends StatelessWidget {
  final Alignment position;

  const DropzoneCorner({super.key, required this.position});

  BoxDecoration _alignedDecoration(Color color) {
    switch (position) {
      case Alignment.topLeft:
        return BoxDecoration(
          border: Border(
            top: BorderSide(color: color, width: 4),
            left: BorderSide(color: color, width: 4),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
          ),
        );
      case Alignment.topRight:
        return BoxDecoration(
          border: Border(
            top: BorderSide(color: color, width: 4),
            right: BorderSide(color: color, width: 4),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
          ),
        );
      case Alignment.bottomLeft:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(color: color, width: 4),
            left: BorderSide(color: color, width: 4),
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
          ),
        );
      case Alignment.bottomRight:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(color: color, width: 4),
            right: BorderSide(color: color, width: 4),
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
          ),
        );
      default:
        throw UnsupportedError('Widget only supports corners.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: position,
      child: Container(
        width: 50,
        height: 50,
        decoration: _alignedDecoration(Theme.of(context).primaryColor),
      ),
    );
  }
}
