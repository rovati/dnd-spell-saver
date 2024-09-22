import 'package:dnd_spell_saver/model/spell.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:dnd_spell_saver/value/area_of_effect.dart';
import 'package:dnd_spell_saver/value/casting_time.dart';
import 'package:dnd_spell_saver/value/class.dart';
import 'package:dnd_spell_saver/value/components.dart';
import 'package:dnd_spell_saver/value/duration.dart';
import 'package:dnd_spell_saver/value/range.dart';
import 'package:dnd_spell_saver/value/saving_throw.dart';
import 'package:dnd_spell_saver/view_spells_screen.dart';
import 'package:dnd_spell_saver/widget/centered_scrollable.dart';
import 'package:dnd_spell_saver/widget/multi_choice_radio.dart';
import 'package:dnd_spell_saver/widget/multi_select_radio.dart';
import 'package:dnd_spell_saver/widget/simple_radio.dart';
import 'package:dnd_spell_saver/widget/simple_radio_with_value.dart';
import 'package:dnd_spell_saver/widget/text_input.dart';
import 'package:dnd_spell_saver/widget/title_input.dart';
import 'package:dnd_spell_saver/widget/value_radio.dart';
import 'package:flutter/material.dart';

import 'value/level.dart';
import 'value/school.dart';
import 'value/source.dart';

class AddSpellPage extends StatefulWidget {
  static const routeName = '/add_spell';

  const AddSpellPage({super.key});

  @override
  State<AddSpellPage> createState() => _AddSpellPageState();
}

class _AddSpellPageState extends State<AddSpellPage> {
  SpellList? _spellList;

  Spell? _spell;
  late bool _isEditing;
  late TextEditingController _titleController;
  late TextEditingController _enTitleController;
  late TextEditingController _bodyController;
  late TextEditingController _higherLevelsController;

  void _addSpell() {
    if (_spell != null) {
      _spell!.title = _titleController.value.text;
      _spell!.sndTitle = _enTitleController.value.text;
      _spell!.body = _bodyController.value.text;
      _spell!.atHigherLevels = _higherLevelsController.value.text;

      var (ok, errors) = _spell!.validate();

      if (!ok) {
        _showErrorDialog(errors);
      } else {
        _spellList!.addSpell(_spell!);
        _showSuccessDialog('Incantesimo aggiunto alla lista.', 'PROSSIMO').then(
          (value) => Navigator.popAndPushNamed(
            context,
            AddSpellPage.routeName,
            arguments: ScreenArguments(
              _spellList!,
            ),
          ),
        );
      }
    }
  }

  void _editSpell() {
    if (_spell != null) {
      _spell!.title = _titleController.value.text;
      _spell!.sndTitle = _enTitleController.value.text;
      _spell!.body = _bodyController.value.text;
      _spell!.atHigherLevels = _higherLevelsController.value.text;

      var (ok, errors) = _spell!.validate();

      if (!ok) {
        _showErrorDialog(errors);
      } else {
        _showSuccessDialog('Incantesimo modificato.', 'OK').then(
          (value) => Navigator.pop(context),
        );
      }
    }
  }

  void _exportCsv() {
    if (_spellList == null) {
      _showErrorDialog(<String>['Lista incantesimi non ancora pronta.']);
    } else {
      _spellList!.exportToCsv().then(
          (value) => _showSuccessDialog('Lista incantesimi esportata.', 'OK'));
    }
  }

  Future<void> _showSuccessDialog(String msg, String btnText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SUCCESSO'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(btnText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Future<void> _showErrorDialog(List<String> errorFields) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Errore di validazione'),
          content: SingleChildScrollView(
            child: ListBody(
              children: (['I seguenti campi contengono errori:'] + errorFields)
                  .map((msg) => Text(msg))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CHIUDI'),
              onPressed: () {
                Navigator.of(context).pop(_spell);
              },
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    _spellList = args.spellList;
    _spell ??= args.spell ?? Spell();
    _isEditing = args.spell != null;
    _titleController = TextEditingController(text: _spell!.title);
    _enTitleController = TextEditingController(text: _spell!.sndTitle);
    _bodyController = TextEditingController(text: _spell!.body);
    _higherLevelsController =
        TextEditingController(text: _spell!.atHigherLevels);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _enTitleController.dispose();
    _bodyController.dispose();
    _higherLevelsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.lightColorScheme.surfaceContainerHighest,
      body: CenteredScrollable(
        padding: 10,
        child: Card(
          elevation: 7,
          surfaceTintColor: AppThemeData.lightColorScheme.surface,
          child: SizedBox(
            width: 710,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TitleInput(
                    'TITOLO',
                    'TITOLO INGLESE',
                    _titleController,
                    _enTitleController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // livello
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadio<SpellLevel>(
                            title: SpellLevel.title,
                            labels: SpellLevel.values,
                            initalValue: _spell?.level,
                            tileWidth: 50,
                            selectionCallback: (val) {
                              _spell?.level = val;
                            },
                          ),
                        ),
                        // scuola
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadio<School>(
                            title: School.title,
                            labels: School.values,
                            initalValue: _spell?.school,
                            tileWidth: 50,
                            selectionCallback: (val) {
                              _spell?.school = val;
                            },
                          ),
                        ),
                        // concentrazione, rituale
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Card(
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  width: 130,
                                  child: Text(
                                    '${Spell.concentrationTitle}:',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Checkbox(
                                  value: _spell?.concentration,
                                  onChanged: (val) {
                                    setState(() {
                                      _spell?.concentration = val!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 130,
                                  child: Text(
                                    '${Spell.ritualTitle}:',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Checkbox(
                                  value: _spell?.ritual,
                                  onChanged: (val) {
                                    setState(() {
                                      _spell?.ritual = val!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // tempo lancio
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadioWithValue<CastingTime>(
                            title: CastingTime.title,
                            labels: CastingTime.values,
                            initialElem:
                                CastingTime.fromString(_spell?.castingTime),
                            initialValue: _spell?.castingTime,
                            tileWidth: 90,
                            hint: CastingTime.hint,
                            selectionCallback: (val) {
                              _spell?.castingTime = val.label;
                            },
                            valueCallback: (strVal) {
                              _spell?.castingTime = strVal;
                            },
                          ),
                        ),
                        // gittata
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadioWithValue<Range>(
                            title: Range.title,
                            labels: Range.values,
                            initialElem: Range.fromString(_spell?.range),
                            initialValue: _spell?.range,
                            tileWidth: 150,
                            hint: Range.hint,
                            selectionCallback: (val) {
                              _spell?.range = val.label;
                            },
                            valueCallback: (strVal) {
                              _spell?.range = strVal;
                            },
                          ),
                        ),
                        // durata
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadioWithValue<Duration>(
                            title: Duration.title,
                            labels: Duration.values,
                            initialElem: Duration.fromString(_spell?.duration),
                            initialValue: _spell?.duration,
                            tileWidth: 220,
                            hint: Duration.hint,
                            selectionCallback: (val) {
                              _spell?.duration = val.label;
                            },
                            valueCallback: (strVal) {
                              _spell?.duration = strVal;
                            },
                          ),
                        ),
                        // componenti
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: MultiChoiceRadio(
                            title: Component.title,
                            labels: Component.values,
                            labelsRequiringValue:
                                Component.labelsRequiringValue(),
                            initialElems: _spell?.components,
                            initialValue: _spell?.materialC,
                            tileWidth: 30,
                            hint: Component.hint,
                            selectionCallback: (val) {
                              _spell?.components.add(val);
                            },
                            deselectionCallback: (val) {
                              _spell?.components.remove(val);
                            },
                            valueCallback: (strVal) {
                              _spell?.materialC = strVal;
                            },
                            valueTileWidth: 370,
                          ),
                        ),
                        // area
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ValueRadio<AreaOfEffect>(
                            title: AreaOfEffect.title,
                            labels: AreaOfEffect.values,
                            labelsRequiringValue:
                                AreaOfEffect.labelsRequiringValue(),
                            initialElem: _spell?.aoe,
                            initalValue: _spell?.aoeDim,
                            tileWidth: 70,
                            valueTileWidth: 100,
                            hint: AreaOfEffect.hint,
                            selectionCallback: (val) {
                              _spell?.aoe = val;
                            },
                            valueCallback: (strVal) {
                              _spell?.aoeDim = strVal;
                            },
                          ),
                        ),
                        // ts
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadio<SavingThrow>(
                            title: SavingThrow.title,
                            labels: SavingThrow.values,
                            tileWidth: 60,
                            initalValue: _spell?.savingThrow,
                            selectionCallback: (val) {
                              _spell?.savingThrow = val;
                            },
                          ),
                        ),
                        // fonte
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadio<Source>(
                            title: Source.title,
                            labels: Source.values,
                            tileWidth: 70,
                            initalValue: _spell?.source,
                            selectionCallback: (val) {
                              _spell?.source = val;
                            },
                          ),
                        ),
                        // classe
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: MultiSelectRadio(
                            title: Class.title,
                            labels: Class.values,
                            tileWidth: 50,
                            initialElems: _spell?.classes,
                            selectionCallback: (val) {
                              _spell?.classes.add(val);
                            },
                            deselectionCallback: (val) {
                              _spell?.classes.remove(val);
                            },
                          ),
                        ),
                        // corpo
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextInput(
                            'Descrizione',
                            _bodyController,
                            minLines: 8,
                          ),
                        ),
                        // livelli alti
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextInput(
                              'Ai livelli più alti', _higherLevelsController),
                        ),
                        // buttons
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: () => _isEditing
                                      ? Navigator.pop(context)
                                      : Navigator.pushNamed(
                                          context,
                                          ViewSpellsPage.routeName,
                                          arguments: ScreenArguments(
                                            _spellList!,
                                          ),
                                        ),
                                  child: const Text("LISTA"),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: _spellList == null
                                      ? null
                                      : _isEditing
                                          ? () => _editSpell()
                                          : () => _addSpell(),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppThemeData
                                          .lightColorScheme.primary),
                                  child: Text(
                                    _isEditing ? 'SALVA' : 'AGGIUNGI',
                                    style: TextStyle(
                                        color: AppThemeData
                                            .lightColorScheme.onPrimary),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: _spellList == null
                                      ? null
                                      : () => _exportCsv(),
                                  child: const Text("ESPORTA CSV"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
