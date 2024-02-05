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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 112, 160, 233)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
