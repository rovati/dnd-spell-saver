import 'package:dnd_spell_saver/util/theme_data.dart';
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
  bool? _valueSelected;
  T? _hovering;
  bool? _hoveringValue;
  String? _value;

  Widget _radioTile(T elem, double width) {
    bool sel = _selected != null && _selected == elem;
    bool hover = _hovering != null && _hovering == elem;

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (event) {
          setState(() {
            _hovering = elem;
          });
        },
        onExit: (event) => (setState(() {
          _hovering = null;
        })),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selected = elem;
              _valueSelected = false;
            });
            widget.selectionCallback(elem);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: elem.toString() == "NO" ? 40 : width,
            height: 25,
            decoration: BoxDecoration(
              color: AppThemeData.containerColor(sel, hover),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                elem.toString(),
                style: TextStyle(
                  color: AppThemeData.textColor(sel, hover),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _valueRadioTile(double width) {
    bool sel = _valueSelected ?? false;
    bool hover = _hoveringValue ?? false;

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (event) {
          setState(() {
            _hoveringValue = true;
          });
        },
        onExit: (event) => (setState(() {
          _hoveringValue = false;
        })),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: width,
          height: 25,
          decoration: BoxDecoration(
            color: AppThemeData.valueContainerColor(sel),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppThemeData.valueContainerBorderColor(sel, hover),
              width: 2,
            ),
          ),
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              onTap: () => setState(() {
                _selected = null;
                _valueSelected = _value != null && _value!.isNotEmpty;
              }),
              onChanged: (text) {
                setState(() {
                  _selected = null;
                  _valueSelected = text.isNotEmpty;
                  _value = text;
                });
                widget.valueCallback(_value ?? "");
              },
              style: TextStyle(
                color: AppThemeData.textColor(sel, hover),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
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
                          (e) => _radioTile(e, widget.tileWidth),
                        )
                        .toList() +
                    [_valueRadioTile(widget.tileWidth)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
