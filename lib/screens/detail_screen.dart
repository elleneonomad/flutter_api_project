import 'package:final_project/async/fake_character_model.dart';
import 'package:final_project/language/language_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final FakeCharacterModel character;
  const DetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final language = context.watch<LanguageLogic>().lang;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: isDarkMode ? Colors.black : Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                character.image,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${language.characterName}: ${character.name}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${language.alternativeName}: ${character.alternateNames}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${language.spices}: ${character.species}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${language.gender}: ${character.gender}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${language.eyeColor}: ${character.eyeColour}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${language.house}: ${character.house}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
