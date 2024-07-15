import 'package:flutter/material.dart';

class CenteredScrollable extends StatelessWidget {
  final Widget child;
  final double padding;
  final bool horizontalOnly;

  const CenteredScrollable({
    super.key,
    required this.child,
    this.padding = 20,
    this.horizontalOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return horizontalOnly
        ? Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: child,
              ),
            ),
          )
        : SingleChildScrollView(
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
