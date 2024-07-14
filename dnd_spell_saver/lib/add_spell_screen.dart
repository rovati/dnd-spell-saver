import 'package:dnd_spell_saver/model/spell.dart';
import 'package:dnd_spell_saver/model/spell_list.dart';
import 'package:dnd_spell_saver/util/screen_args.dart';
import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:dnd_spell_saver/value/area_of_effect.dart';
import 'package:dnd_spell_saver/value/casting_time.dart';
import 'package:dnd_spell_saver/value/components.dart';
import 'package:dnd_spell_saver/value/duration.dart';
import 'package:dnd_spell_saver/value/range.dart';
import 'package:dnd_spell_saver/value/saving_throw.dart';
import 'package:dnd_spell_saver/view_spells_screen.dart';
import 'package:dnd_spell_saver/widget/centered_scrollable.dart';
import 'package:dnd_spell_saver/widget/multi_choice_radio.dart';
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
  SpellList? _spellList = SpellList.mock();

  final _titleController = TextEditingController();
  final _enTitleController = TextEditingController();
  final _schoolController = TextEditingController();
  final _spellLevelController = TextEditingController();
  final _bodyController = TextEditingController();
  final _higherLevelsController = TextEditingController();

  Source? _source;
  SpellLevel? _spellLevel;
  School? _school;
  bool _concentration = false;
  bool _ritual = false;
  CastingTime? _castingTime;
  String? _strCastingTime;
  Range? _range;
  String? _strRange;
  Duration? _duration;
  String? _strDuration;
  final List<Component> _components = [];
  String? _material;
  AreaOfEffect? _area;
  String? _dimAoE;
  SavingThrow? _savingThrow;

  void _addSpell() {
    // TODO validation
    List<String> errorFields = [];

    if (_titleController.value.text.isEmpty) {
      errorFields.add('\'TITOLO\' è vuoto.');
    }
    if (_enTitleController.value.text.isEmpty) {
      errorFields.add('\'TITOLO ENG\' è vuoto.');
    }
    if (_source == null) {
      errorFields.add('\'FONTE\' non è selezionato.');
    }
    if (_spellLevel == null) {
      errorFields.add('\'LIVELLO\' non è selezionato.');
    }
    if (_school == null) {
      errorFields.add('\'SCUOLA\' non è selezionato.');
    }
    if (_castingTime == null && _strCastingTime == null) {
      errorFields.add('\'TEMPO DI LANCIO\' non è selezionato.');
    } else if (_castingTime == null && _strCastingTime!.isEmpty) {
      errorFields.add(
          '\'TEMPO DI LANCIO\' ha un valore non default, ma il valore è vuoto.');
    }
    if (_range == null && _strRange == null) {
      errorFields.add('\'GITTATA\' non è selezionato.');
    } else if (_range == null && _strRange!.isEmpty) {
      errorFields
          .add('\'GITTATA\' ha un valore non default, ma il valore è vuoto.');
    }
    if (_duration == null && _strDuration == null) {
      errorFields.add('\'DURATA\' non è selezionato.');
    } else if (_duration == null && _strDuration!.isEmpty) {
      errorFields
          .add('\'DURATA\' ha un valore non default, ma il valore è vuoto.');
    }
    if (_components.contains(Component.material) &&
        (_material == null || _material!.isEmpty)) {
      errorFields
          .add('\'COMPONENTI\' contiene Materiale ma non specifica quale.');
    }
    if (_area == null) {
      errorFields.add('\'AREA\' non è selezionato.');
    } else if (_area != AreaOfEffect.none &&
        (_dimAoE == null || _dimAoE!.isEmpty)) {
      errorFields
          .add('\'AREA\' ha un tipo di area ma non specifica la dimensione.');
    }
    if (_savingThrow == null) {
      errorFields.add('\'TIRO SLAVEZZA\' non è selezionato.');
    }
    if (_bodyController.value.text.isEmpty) {
      errorFields.add('\'DESCRIZIONE\' è vuoto.');
    }

    if (errorFields.isNotEmpty) {
      _showErrorDialog(errorFields);
      return;
    }

    var spell = Spell(
      _titleController.value.text,
      _enTitleController.value.text,
      _source!,
      _spellLevel!,
      _school!,
      _concentration,
      _ritual,
      _castingTime != null ? _castingTime!.label : _strCastingTime!,
      _range != null ? _range!.label : _strRange!,
      _duration != null ? _duration!.label : _strDuration!,
      _components,
      _material ?? "",
      _area!,
      _dimAoE ?? "",
      _savingThrow!,
      _bodyController.value.text,
      _higherLevelsController.value.text,
    );

    _spellList!.addSpell(spell);
    _showSuccessDialog('Incantesimo aggiunto alla lista.').then(
      (value) => Navigator.popAndPushNamed(
        context,
        AddSpellPage.routeName,
        arguments: ScreenArguments(
          _spellList!,
        ),
      ),
    );
  }

  void _exportCsv() {
    if (_spellList == null) {
      _showErrorDialog(<String>['Lista incantesimi non ancora pronta.']);
    } else {
      _spellList!
          .exportToCsv()
          .then((value) => _showSuccessDialog('Lista incantesimi esportata.'));
    }
  }

  Future<void> _showSuccessDialog(String msg) async {
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
              child: const Text('PROSSIMO'),
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
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /*final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    setState(() {
      _spellList = args.spellList;
    });*/

    return Scaffold(
      backgroundColor: AppThemeData.lightColorScheme.surfaceVariant,
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
                        // livello scuola
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Card(
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  width: 60,
                                  child: Text(
                                    "LIVELLO:",
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: DropdownMenu<SpellLevel>(
                                    width: 200,
                                    hintText: "SELEZIONA",
                                    controller: _spellLevelController,
                                    requestFocusOnTap: true,
                                    enableSearch: false,
                                    onSelected: (SpellLevel? level) {
                                      setState(() {
                                        _spellLevel = level;
                                      });
                                    },
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    textStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    dropdownMenuEntries: SpellLevel.values
                                        .map<DropdownMenuEntry<SpellLevel>>(
                                            (SpellLevel level) {
                                      return DropdownMenuEntry<SpellLevel>(
                                        value: level,
                                        label: level.label,
                                        style: MenuItemButton.styleFrom(
                                            foregroundColor: level ==
                                                    _spellLevel
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                            backgroundColor: Colors.white),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                const SizedBox(
                                  width: 60,
                                  child: Text(
                                    "SCUOLA:",
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: DropdownMenu<School>(
                                    width: 200,
                                    hintText: "SELEZIONA",
                                    controller: _schoolController,
                                    requestFocusOnTap: true,
                                    enableSearch: false,
                                    onSelected: (School? school) {
                                      setState(() {
                                        _school = school;
                                      });
                                    },
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    textStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    dropdownMenuEntries: School.values
                                        .map<DropdownMenuEntry<School>>(
                                            (School school) {
                                      return DropdownMenuEntry<School>(
                                        value: school,
                                        label: school.label,
                                        style: MenuItemButton.styleFrom(
                                            foregroundColor: school == _school
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                            backgroundColor: Colors.white),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
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
                                    "CONCENTRAZIONE:",
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Checkbox(
                                  value: _concentration,
                                  onChanged: (val) {
                                    setState(() {
                                      _concentration = val!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 130,
                                  child: Text(
                                    "RITUALE:",
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Checkbox(
                                  value: _ritual,
                                  onChanged: (val) {
                                    setState(() {
                                      _ritual = val!;
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
                            title: 'TEMPO DI LANCIO',
                            labels: CastingTime.values,
                            tileWidth: 90,
                            hint: CastingTime.hint,
                            selectionCallback: (val) {
                              _castingTime = val;
                            },
                            valueCallback: (strVal) {
                              _strCastingTime = strVal;
                            },
                          ),
                        ),
                        // gittata
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadioWithValue<Range>(
                            title: 'GITTATA',
                            labels: Range.values,
                            tileWidth: 150,
                            hint: Range.hint,
                            selectionCallback: (val) {
                              _range = val;
                            },
                            valueCallback: (strVal) {
                              _strRange = strVal;
                            },
                          ),
                        ),
                        // durata
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadioWithValue<Duration>(
                            title: 'DURATA',
                            labels: Duration.values,
                            tileWidth: 220,
                            hint: Duration.hint,
                            selectionCallback: (val) {
                              _duration = val;
                            },
                            valueCallback: (strVal) {
                              _strDuration = strVal;
                            },
                          ),
                        ),
                        // componenti
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: MultiChoiceRadio(
                            title: 'COMPONENTI',
                            labels: Component.values,
                            labelsRequiringValue:
                                Component.labelsRequiringValue(),
                            tileWidth: 30,
                            hint: Component.hint,
                            selectionCallback: (val) {
                              _components.add(val);
                            },
                            deselectionCallback: (val) {
                              _components.remove(val);
                            },
                            valueCallback: (strVal) {
                              _material = strVal;
                            },
                            valueBound: const [Component.material],
                            valueTileWidth: 370,
                          ),
                        ),
                        // area
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ValueRadio<AreaOfEffect>(
                            title: 'AREA',
                            labels: AreaOfEffect.values,
                            labelsRequiringValue:
                                AreaOfEffect.labelsRequiringValue(),
                            tileWidth: 70,
                            valueTileWidth: 100,
                            hint: AreaOfEffect.hint,
                            selectionCallback: (val) {
                              _area = val;
                            },
                            valueCallback: (strVal) {
                              _dimAoE = strVal;
                            },
                          ),
                        ),
                        // ts
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadio<SavingThrow>(
                            title: 'TIRO SALVEZZA',
                            labels: SavingThrow.values,
                            tileWidth: 60,
                            selectionCallback: (val) {
                              _savingThrow = val;
                            },
                          ),
                        ),
                        // fonte
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SimpleRadio<Source>(
                            title: 'FONTE',
                            labels: Source.values,
                            tileWidth: 70,
                            selectionCallback: (val) {
                              _source = val;
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
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    ViewSpellsPage.routeName,
                                    arguments: ScreenArguments(
                                      _spellList!,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 220, 226, 233),
                                  ),
                                  child: Text(
                                    "LISTA",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
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
                                      : () => _addSpell(),
                                  child: const Text(
                                    "AGGIUNGI",
                                    style: TextStyle(color: Colors.white),
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
                                  child: const Text(
                                    "ESPORTA CSV",
                                    style: TextStyle(color: Colors.white),
                                  ),
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
