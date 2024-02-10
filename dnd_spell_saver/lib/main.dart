import 'package:dnd_spell_saver/add_spell_screen.dart';
import 'package:dnd_spell_saver/main_screen.dart';
import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:dnd_spell_saver/view_spells_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your problems.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DnD Spell Saver',
      theme: ThemeData(
        colorScheme: AppThemeData.lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: AppThemeData.darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      initialRoute: AddSpellPage.routeName,
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        AddSpellPage.routeName: (context) => const AddSpellPage(),
        ViewSpellsPage.routeName: (context) => const ViewSpellsPage(),
      },
    );
  }
}
