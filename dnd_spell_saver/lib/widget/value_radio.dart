import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class ValueRadio<T> extends StatefulWidget {
  final String title;
  final List<T> labels;
  final List<T> labelsRequiringValue;
  final T? initialElem;
  final String? initalValue;
  final double tileWidth;
  final double valueTileWidth;
  final bool noTile;
  final String hint;
  final bool allowMultiple;
  final void Function(T val) selectionCallback;
  final void Function(T val)? deselectionCallback;
  final void Function(String strVal) valueCallback;

  const ValueRadio(
      {super.key,
      required this.title,
      required this.labels,
      required this.labelsRequiringValue,
      this.initialElem,
      this.initalValue,
      required this.tileWidth,
      required this.hint,
      required this.selectionCallback,
      required this.valueCallback,
      this.noTile = false,
      this.allowMultiple = false,
      this.deselectionCallback,
      this.valueTileWidth = 0});

  @override
  State<StatefulWidget> createState() => _ValueRadioState<T>();
}

class _ValueRadioState<T> extends State<ValueRadio<T>> {
  T? _selected;
  T? _hovering;
  bool? _hoveringValue;
  String? _value;
  late TextEditingController _valueController;

  Widget _simpleRadioTile(T elem, double width) {
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
    bool required = widget.labelsRequiringValue.contains(_selected);
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
            color: AppThemeData.valueContainerColor(
                required && _value != null && _value!.isNotEmpty),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppThemeData.valueContainerBorderColor(required, hover),
              width: 2,
            ),
          ),
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _valueController,
              style: TextStyle(
                color: AppThemeData.textColor(required, hover),
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
  void initState() {
    super.initState();
    _selected = widget.initialElem;
    _value = widget.labelsRequiringValue.contains(_selected)
        ? widget.initalValue
        : null;
    _valueController = TextEditingController(text: _value ?? '');
    _valueController.addListener(() {
      _value = _valueController.text;
      widget.valueCallback(_value ?? '');
    });
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
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
                        .map((e) => _simpleRadioTile(e, widget.tileWidth))
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
