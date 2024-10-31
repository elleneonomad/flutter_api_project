import 'package:final_project/language/language_logic.dart';
import 'package:final_project/screens/about_us_screen.dart';
import 'package:final_project/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/async/dark_logic.dart';
import 'fake_character_logic.dart';
import '../screens/fakecharacter_screen.dart';

Widget asynAppWithProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FakecharacterLogic()),
      ChangeNotifierProvider(create: (context) => DarkLogic()),
      ChangeNotifierProvider(create: (context) => LanguageLogic()),
    ],
    child: const SplashScreen(),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _readAll(BuildContext context) async {
    await context.read<FakecharacterLogic>().read();
    await context.read<DarkLogic>().readCache();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _readAll(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const AsyncApp();
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Replace Icon with Image.asset
              Image.asset(
                'photos/harry_potter.png',
                width: 100,
                height: 100,
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class AsyncApp extends StatefulWidget {
  const AsyncApp({super.key});

  @override
  _AsyncAppState createState() => _AsyncAppState();
}

class _AsyncAppState extends State<AsyncApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int themeIndex = context.watch<DarkLogic>().themeIndex;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeIndex == 0
          ? ThemeMode.system
          : themeIndex == 1
              ? ThemeMode.light
              : ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: _selectedIndex == 0
            ? const FakeCharacterScreen() // Home screen with card navigation
            : _selectedIndex == 1
                ? SearchScreen() // The Search Screen
                : AboutUsScreen(), // The About Us Screen
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Home icon
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search), // Search icon
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info), // About Us icon
              label: 'About Us',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
