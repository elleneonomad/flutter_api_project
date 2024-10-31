import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/language/language_constant.dart';
import 'package:final_project/language/language_logic.dart';
import 'package:final_project/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../async/dark_logic.dart';
import '../async/fake_character_logic.dart';
import '../async/fake_character_model.dart';

class FakeCharacterScreen extends StatefulWidget {
  const FakeCharacterScreen({super.key});

  @override
  State<FakeCharacterScreen> createState() => _FakeCharacterScreenState();
}

class _FakeCharacterScreenState extends State<FakeCharacterScreen> {
  Language _language = Khmer();
  int _languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _language = context.watch<LanguageLogic>().lang;
    _languageIndex = context.watch<LanguageLogic>().languageIndex;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_language.appName),
        backgroundColor: isDarkMode ? Colors.black : Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    int themeIndex = context.watch<DarkLogic>().themeIndex;
    int currentLanguageIndex = context.watch<LanguageLogic>().languageIndex;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Icon(Icons.face)),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: Text(_language.systemMode),
            onTap: () {
              context.read<DarkLogic>().changeToSystem();
            },
            trailing: themeIndex == 0 ? const Icon(Icons.check) : null,
          ),
          ListTile(
            leading: const Icon(Icons.light_mode),
            title: Text(_language.lightMode),
            onTap: () {
              context.read<DarkLogic>().changeToLight();
            },
            trailing: themeIndex == 1 ? const Icon(Icons.check) : null,
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(_language.darkMode),
            onTap: () {
              context.read<DarkLogic>().changeToDark();
            },
            trailing: themeIndex == 2 ? const Icon(Icons.check) : null,
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(_language.toKhmer),
            onTap: () {
              context.read<LanguageLogic>().changeToKhmer();
            },
            trailing:
                currentLanguageIndex == 0 ? const Icon(Icons.check) : null,
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(_language.toEnglish),
            onTap: () {
              context.read<LanguageLogic>().changeToEnglish();
            },
            trailing:
                currentLanguageIndex == 1 ? const Icon(Icons.check) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    bool loading = context.watch<FakecharacterLogic>().loading;
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    String? error = context.watch<FakecharacterLogic>().error;

    if (error != null) {
      return _buildError(error);
    }

    List<FakeCharacterModel> characterList =
        context.watch<FakecharacterLogic>().characterList;

    // Group characters by house
    final Map<String, List<FakeCharacterModel>> charactersByHouse = {};
    for (var character in characterList) {
      charactersByHouse.putIfAbsent(character.house, () => []).add(character);
    }

    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: charactersByHouse.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                entry.key,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: entry.value.length,
                itemBuilder: (context, index) {
                  return _buildItem(entry.value[index]);
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildError(String error) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          ElevatedButton(
            onPressed: () async {
              context.read<FakecharacterLogic>().setLoading();
              await Future.delayed(const Duration(seconds: 1));
              context.read<FakecharacterLogic>().read();
            },
            child: const Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(FakeCharacterModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(character: item),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CachedNetworkImage(
                imageUrl: item.image,
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[900],
                ),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.house,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
