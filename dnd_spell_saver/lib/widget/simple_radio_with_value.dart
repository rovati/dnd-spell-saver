import 'package:flutter/material.dart';

class SimpleRadioWithValue<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
  final double tileWidth;
  final bool noTile;
  final String hint;
  final void Function(T newVal) selectionCallback;
  final void Function(String newStrVal) valueCallback;

  const SimpleRadioWithValue(
      {super.key,
      required this.title,
      required this.labels,
      required this.tileWidth,
      required this.hint,
      required this.selectionCallback,
      required this.valueCallback,
      this.noTile = false});

  @override
  State<StatefulWidget> createState() => _SimpleRadioWithValueState<T>();
}

class _SimpleRadioWithValueState<T> extends State<SimpleRadioWithValue<T>> {
  T? _selected;
  String? _value;

  Widget _simpleRadioTile(T elem, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selected = elem;
            _value = null;
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

  Widget _valueRadioTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        width: widget.tileWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 2,
              color: _selected == null && _value != null && _value!.isNotEmpty
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
                  _selected = null;
                  _value = text;
                });
                widget.valueCallback(_value ?? "");
              },
              style: TextStyle(
                  color:
                      _selected == null && _value != null && _value!.isNotEmpty
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
      ),
    );
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
                        .map(
                          (e) => _simpleRadioTile(e, widget.tileWidth),
                        )
                        .toList() +
                    [_valueRadioTile()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
