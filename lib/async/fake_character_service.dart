import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'fake_character_model.dart';

class FakecharacterService {
  static Future<List<FakeCharacterModel>> getAPI() async {
    String url = "https://hp-api.onrender.com/api/characters";
    http.Response res = await http.get(Uri.parse(url));
    return compute(fakeCharacterModelFromJson, res.body);
  }
}
