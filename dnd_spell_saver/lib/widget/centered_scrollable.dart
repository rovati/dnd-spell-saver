import 'package:flutter/material.dart';

class CenteredScrollable extends StatelessWidget {
  final Widget child;
  final double padding;

  const CenteredScrollable({
    super.key,
    required this.child,
    this.padding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
