import 'package:dnd_spell_saver/util/theme_data.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  final String titleHint;
  final String secondTitleHint;
  final TextEditingController titleController;
  final TextEditingController secondTitleController;

  const TitleInput(this.titleHint, this.secondTitleHint, this.titleController,
      this.secondTitleController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppThemeData.lightColorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppThemeData.lightColorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10)),
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  hintText: titleHint,
                  hintStyle: const TextStyle(
                      fontSize: 20, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                ),
                controller: titleController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 300,
              height: 35,
              decoration: BoxDecoration(
                  color: AppThemeData.lightColorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: secondTitleHint,
                    hintStyle: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  controller: secondTitleController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
