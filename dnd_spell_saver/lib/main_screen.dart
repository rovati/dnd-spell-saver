import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/widget/centered_scrollable.dart';
import 'package:dnd_spell_saver/widget/dropzone_corner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _newCsvAndNavigate(BuildContext context) {
    var spellList = SpellList();
    Navigator.pushNamed(
      context,
      AddSpellPage.routeName,
      arguments: ScreenArguments(
        spellList,
      ),
    );
  }

  void _loadCsvAndNavigate(BuildContext context) {
    var spellList = SpellList();
    spellList.loadCsv();
    Navigator.pushNamed(
      context,
      AddSpellPage.routeName,
      arguments: ScreenArguments(
        spellList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Colors.grey,
        ),
        child: CenteredScrollable(
          padding: 20,
          child: SizedBox(
            width: 650,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "An Unnecessarily Large Title",
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _newCsvAndNavigate(context);
                    },
                    child: const Text(
                      "NUOVO CSV",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 350,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DropzoneView(
                        onDrop: (val) => print("Dropped"),
                      ),
                      Container(
                        width: 350,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 218, 218, 218),
                        ),
                      ),
                      const DropzoneCorner(position: Alignment.topLeft),
                      const DropzoneCorner(position: Alignment.topRight),
                      const DropzoneCorner(position: Alignment.bottomLeft),
                      const DropzoneCorner(position: Alignment.bottomRight),
                      Container(
                        width: 350 - 4 - 4,
                        height: 200 - 4 - 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                        ),
                      ),
                      const Column(
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
