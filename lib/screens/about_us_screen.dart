import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/language/language_logic.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({super.key});

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  double _fontSize = 20.0; // Initial font size

  void _increaseFontSize() {
    setState(() {
      if (_fontSize < 24) {
        _fontSize += 2; // Increase by 2 until max 24
      }
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 16) {
        _fontSize -= 2; // Decrease by 2 until min 16
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final language = context.watch<LanguageLogic>().lang;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _increaseFontSize,
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: _decreaseFontSize,
            icon: Icon(Icons.remove),
          ),
        ],
        title: Text(language.aboutUs),
        backgroundColor: isDarkMode ? Colors.black : Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'photos/harry_potter.png'), // Background image path
                fit: BoxFit.contain, // Adjust to cover
              ),
            ),
          ),
          // Foreground content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(height: 20),
                  Text(
                    "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The novels chronicle the lives of a young wizard, Harry Potter, and his friends, Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry. The main story arc concerns Harry's conflict with Lord Voldemort, a dark wizard who intends to become immortal, overthrow the wizard governing body known as the Ministry of Magic, and subjugate all wizards and Muggles (non-magical people).",
                    style: TextStyle(fontSize: _fontSize), // Dynamic font size
                  ),
                  SizedBox(height: 20),
                  Text(
                    "The series was originally published in English by Bloomsbury in the United Kingdom and Scholastic Press in the United States. A series of many genres, including fantasy, drama, coming-of-age fiction, and the British school story (which includes elements of mystery, thriller, adventure, horror, and romance), the world of Harry Potter explores numerous themes and includes many cultural meanings and references. Major themes in the series include prejudice, corruption, madness, love, and death. Since the release of the first novel, Harry Potter and the Philosopher's Stone, on 26 June 1997, the books have found immense popularity and commercial success worldwide. They have attracted a wide adult audience as well as younger readers and are widely considered cornerstones of modern literature, though the books have received mixed reviews from critics and literary scholars. As of February 2023, the books have sold more than 600 million copies worldwide, making them the best-selling book series in history, available in dozens of languages. The last four books all set records as the fastest-selling books in history, with the final instalment selling roughly 2.7 million copies in the United Kingdom and 8.3 million copies in the United States within twenty-four hours of its release.",
                    style: TextStyle(fontSize: _fontSize), // Dynamic font size
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
