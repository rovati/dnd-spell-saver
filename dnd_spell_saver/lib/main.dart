import 'package:flutter/material.dart';

import 'add_spell_screen.dart';

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
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color.fromARGB(255, 124, 168, 235),
            onPrimary: Colors.white,
            secondary: Color.fromARGB(255, 255, 255, 255),
            onSecondary: Color.fromARGB(255, 104, 104, 104),
            error: Color.fromARGB(255, 196, 49, 49),
            onError: Colors.white,
            background: Color.fromARGB(255, 220, 226, 233),
            onBackground: Color.fromARGB(255, 100, 100, 100),
            surface: Color.fromARGB(255, 124, 168, 235),
            onSurface: Colors.grey),
        useMaterial3: true,
      ),
      home: const AddSpellPage(),
    );
  }
}
