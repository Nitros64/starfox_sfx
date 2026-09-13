import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show AssetManifest, rootBundle;
import 'package:starfox_sfx/core/util/character_data_provider.dart';
import 'package:starfox_sfx/features/domain/entities/character.dart';

class _CharacterAudioProvider {
  static const String _defaultWorld = 'default';
  // iOS no reproduce .ogg de forma nativa
  static final Set<String> _playableAudioExtensions = {
    '.aiff',
    '.m4a',
    '.mp3',
    '.wav',
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) '.ogg',
  };

  _CharacterAudioProvider();

  Future<List<String>> listAssetFiles(String directoryPath) async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    return assetManifest
        .listAssets()
        .where(
          (path) =>
              path.startsWith(directoryPath) &&
              _playableAudioExtensions.any(path.toLowerCase().endsWith),
        )
        .toList();
  }

  Future<Character> loadCharacter({
    required String nameCharacter,
    String world = _defaultWorld,
  }) async {
    try {
      if (world == _defaultWorld) {
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
    List<String> characterAudioFiles = await listAssetFiles(
      'assets/audios/$nameCharacter',
    );
    Character character = CharacterDataProvider.characters.firstWhere(
      (c) => c.name == nameCharacter,
    );
    character.voices = characterAudioFiles;
    return character;
  }

  Future<Character> loadCharacterAudioFilesByWorld(
    String nameCharacter,
    String world,
  ) async {
    List<String> characterAudioFiles = await listAssetFiles(
      'assets/audios/$nameCharacter/$world',
    );
    Character character = CharacterDataProvider.characters.firstWhere(
      (c) => c.name == nameCharacter,
    );
    character.voices = characterAudioFiles;
    return character;
  }
}

final characterProvider = _CharacterAudioProvider();
