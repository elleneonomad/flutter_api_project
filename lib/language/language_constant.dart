List<Language> langList = [
  Khmer(),
  Language(),
];

class Language {
  String get systemMode => "System Mode";
  String get darkMode => "Dark Mode";
  String get lightMode => "Light Mode";
  String get language => "Language";
  String get toKhmer => "ប្តូរទៅភាសាខ្មែរ";
  String get toEnglish => "Change To English";
  String get appName => "Harry Potter Characters";
  String get characterName => "Character Name: ";
  String get alternativeName => "About: ";
  String get spices => "Spices: ";
  String get eyeColor => "Eye Color: ";
  String get house => "House: ";
  String get gender => "Gender: ";
  String get search => "Search Characters";
  String get searchHint => "Search for the Character";
  String get bodyMessage => "Search for any Characters in Harry Potter";
  String get errorMessage => "No characters found";
  String get aboutUs => "About Us";
  String get teamMembers => "Team Members";
}

class Khmer implements Language {
  @override
  String get systemMode => "ប្តូរពន្លឺតាមប្រព័ន្ធ";
  @override
  String get darkMode => "ប្តូរទៅងងឹត";
  @override
  String get lightMode => "ប្តូរទៅភ្លឺ";
  @override
  String get language => "ភាសា";
  @override
  String get toKhmer => "ប្តូរទៅភាសាខ្មែរ";
  @override
  String get toEnglish => "Change To English";
  @override
  String get appName => "ហេរីផតធរ";
  @override
  String get characterName => "នាមតួអង្គ";
  @override
  String get alternativeName => "អំពី";
  @override
  String get spices => "ប្រភេទ";
  @override
  String get eyeColor => "ពណ៌ភ្នែក";
  @override
  String get gender => "ភេទ";
  @override
  String get search => "ស្វែងរកតួអង្គ";
  @override
  String get searchHint => "ស្វែងរក...";
  @override
  String get bodyMessage => "វាយបញ្ចូលក្នុងរបារស្វែងរក";
  @override
  String get errorMessage => "រកមិនឃើញតួអង្គ";
  @override
  String get aboutUs => "អំពីពួកយើង";
  @override
  String get teamMembers => "សមាជិកក្រុម";
  @override
  String get house => "ផ្ទះ";
}
