import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int minLines;

  const TextInput(
    this.hintText,
    this.controller, {
    super.key,
    this.minLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppThemeData.lightColorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: minLines,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
