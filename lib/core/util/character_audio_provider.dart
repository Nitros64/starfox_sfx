import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:starfox_sfx/core/util/character_data_provider.dart';
import 'package:starfox_sfx/features/domain/entities/character.dart';

class _CharacterAudioProvider {

  static const String _defaultWorld = 'default';

  _CharacterAudioProvider();

  Future<List<String>> listAssetFiles(String directoryPath) async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestJson);

    return manifestMap.keys
        .where((path) => path.startsWith(directoryPath))
        .toList();
  }  

  Future<Character> loadCharacter({required String nameCharacter, String world = _defaultWorld}) async {
    try {
      if(world == _defaultWorld){
        return await loadAllCharacterAudioFiles(nameCharacter);
      }

      return await loadCharacterAudioFilesByWorld(nameCharacter, world);
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar el archivo JSON: $e');
      }
      rethrow;
    }    
  }

  Future<Character> loadAllCharacterAudioFiles(String nameCharacter) async {
    List<String> characterAudioFiles = await listAssetFiles('assets/audios/$nameCharacter');
    Character character = CharacterDataProvider.characters.firstWhere((c) => c.name == nameCharacter);
    character.voices = characterAudioFiles;
    return character;
  }

  Future<Character> loadCharacterAudioFilesByWorld(String nameCharacter, String world) async {
    List<String> characterAudioFiles = await listAssetFiles('assets/audios/$nameCharacter/$world');
    Character character = CharacterDataProvider.characters.firstWhere((c) => c.name == nameCharacter);
    character.voices = characterAudioFiles;
    return character;
  }

}

final characterProvider = _CharacterAudioProvider();