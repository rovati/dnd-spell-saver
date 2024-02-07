import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/dropzone_state.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/widget/dropzone_corner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class StyledDropzone extends StatefulWidget {
  const StyledDropzone({super.key});

  @override
  State<StatefulWidget> createState() => _StyledDropzoneState();
}

class _StyledDropzoneState extends State<StyledDropzone> {
  SpellList? _spellList;
  DropzoneState _dzState = DropzoneState.ready;
  late DropzoneViewController _dzController;
  String? _errMsg;
  double _readyOpacity = 1;
  double _hoveringOpacity = 0;
  double _loadingOpacity = 0;
  double _errorOpacity = 0;
  double _completedOpacity = 0;
  int _loadedSpells = 0;
  int _totalSpells = 0;

  Widget _dropzoneContent(DropzoneState state) {
    switch (state) {
      case DropzoneState.ready:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              color: Colors.grey,
              size: 35,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'TRASCINA QUI',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      case DropzoneState.hovering:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.album_outlined,
              color: Color.fromARGB(255, 238, 231, 132),
              size: 35,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'RILASCIA IL FILE',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      case DropzoneState.loading:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Color.fromARGB(255, 238, 201, 132)),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'CARICANDO IL FILE',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      case DropzoneState.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Color.fromARGB(255, 231, 72, 72),
              size: 35,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              _errMsg ?? 'ERRORE',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 231, 72, 72)),
            ),
          ],
        );
      case DropzoneState.completed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified,
              color: Color.fromARGB(255, 132, 238, 159),
              size: 35,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'CARICATO $_loadedSpells SPELLS (DI $_totalSpells)',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        );
    }
  }

  Color _borderColor(DropzoneState state) {
    switch (state) {
      case DropzoneState.ready:
        return const Color.fromARGB(255, 218, 218, 218);
      case DropzoneState.hovering:
        return const Color.fromARGB(255, 238, 231, 132);
      case DropzoneState.loading:
        return const Color.fromARGB(255, 238, 201, 132);
      case DropzoneState.error:
        return const Color.fromARGB(255, 231, 72, 72);
      case DropzoneState.completed:
        return const Color.fromARGB(255, 132, 238, 159);
    }
  }

  void _updateState(DropzoneState state) {
    setState(() {
      _dzState = state;
      _readyOpacity = _dzState == DropzoneState.ready ? 1.0 : 0.0;
      _hoveringOpacity = _dzState == DropzoneState.hovering ? 1.0 : 0.0;
      _loadingOpacity = _dzState == DropzoneState.loading ? 1.0 : 0.0;
      _errorOpacity = _dzState == DropzoneState.error ? 1.0 : 0.0;
      _completedOpacity = _dzState == DropzoneState.completed ? 1.0 : 0.0;
    });
  }

  void _loadSpellList(String fileContent) {
    var spellList = SpellList();
    var (l, s) = spellList.loadCsv(fileContent);
    _loadedSpells = l;
    _totalSpells = s;
    _spellList = spellList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DropzoneView(
            cursor: CursorType.grab,
            onHover: () => _updateState(DropzoneState.hovering),
            onLeave: () => _updateState(DropzoneState.ready),
            onDrop: (ev) async {
              _updateState(DropzoneState.loading);
              final mime = await _dzController.getFileMIME(ev);
              if (mime != "text/csv") {
                _errMsg = 'IL FILE DEVE ESSERE .CVS';
                _updateState(DropzoneState.error);
                print(mime);
              } else {
                final bytes = await _dzController.getFileData(ev);
                _loadSpellList(String.fromCharCodes(bytes));
                _updateState(DropzoneState.completed);

                Future.delayed(const Duration(seconds: 3)).then((value) {
                  if (_spellList != null) {
                    Navigator.pushNamed(
                      context,
                      AddSpellPage.routeName,
                      arguments: ScreenArguments(
                        _spellList!,
                      ),
                    );
                  } else {
                    _errMsg = 'SI È VERIFICATO UN ERRORE';
                    _updateState(DropzoneState.error);
                  }
                });

                print(String.fromCharCodes(bytes));
              }
            },
            onError: (err) {
              _errMsg = 'SI È VERIFICATO UN ERRORE';
              _updateState(DropzoneState.error);
            },
            onCreated: (ctrl) => _dzController = ctrl,
          ),
          // grey border
          AnimatedContainer(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _borderColor(_dzState),
            ),
            duration: const Duration(milliseconds: 200),
          ),
          // corners
          const DropzoneCorner(position: Alignment.topLeft),
          const DropzoneCorner(position: Alignment.topRight),
          const DropzoneCorner(position: Alignment.bottomLeft),
          const DropzoneCorner(position: Alignment.bottomRight),
          // white background
          Container(
            width: 350 - 4 - 4,
            height: 200 - 4 - 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
          ),
          // content
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: _readyOpacity,
                duration: const Duration(milliseconds: 250),
                child: _dropzoneContent(DropzoneState.ready),
              ),
              AnimatedOpacity(
                opacity: _hoveringOpacity,
                duration: const Duration(milliseconds: 250),
                child: _dropzoneContent(DropzoneState.hovering),
              ),
              AnimatedOpacity(
                opacity: _loadingOpacity,
                duration: const Duration(milliseconds: 250),
                child: _dropzoneContent(DropzoneState.loading),
              ),
              AnimatedOpacity(
                opacity: _errorOpacity,
                duration: const Duration(milliseconds: 250),
                child: _dropzoneContent(DropzoneState.error),
              ),
              AnimatedOpacity(
                opacity: _completedOpacity,
                duration: const Duration(milliseconds: 250),
                child: _dropzoneContent(DropzoneState.completed),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
