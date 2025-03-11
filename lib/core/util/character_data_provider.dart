import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:starfox_sfx/features/domain/entities/character.dart';

class CharacterDataProvider {
  static List<Character> characters = [];
  static List<Character> characterSecrets = [];
  static const String _characterDataFile = 'data/characters.json';
  static const String _characterDataFileSecrets = 'data/characters_secrets.json';

  static Future<void> loadCharacters() async {
    try {
      final String jsonString = await rootBundle.loadString(_characterDataFile);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      characters = (jsonData['characters'] as List)
          .map((char) => Character.fromJson(char))
          .toList();
      
    if (kDebugMode) {
      print("Loaded ${characters.length} characters.");
    }
      
    } catch (e) {
      if (kDebugMode) {
        print("Error loading characters: $e");
      }
    }
  }

  static Future<void> loadCharacterSecrets() async {
    try {
      final String jsonString = await rootBundle.loadString(_characterDataFileSecrets);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      characterSecrets = (jsonData['characterSecrets'] as List)
          .map((char) => Character.fromJson(char))
          .toList();
      
    if (kDebugMode) {
      print("Loaded ${characters.length} characters.");
    }
      
    } catch (e) {
      if (kDebugMode) {
        print("Error loading characters: $e");
      }
    }
  }

 // static 
}