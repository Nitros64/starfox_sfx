import 'package:starfox_sfx/core/util/character_data_provider.dart';
import 'package:starfox_sfx/features/domain/entities/character.dart';

void swapCharacters(Character a, Character b) {
  var temp = Character.fromCharacter(a);

  a.name = b.name;
  a.mountClosed = b.mountClosed;
  a.mountOpen = b.mountOpen;
  a.voices = b.voices;

  b.name = temp.name;
  b.mountClosed = temp.mountClosed;
  b.mountOpen = temp.mountOpen;
  b.voices = temp.voices;
}

bool checkIfExists(List<Character> characterList, String charName) {
  return characterList.any((char) => char.name == charName.toLowerCase());
}

bool checkCharacterSecret(String charName) {
  return CharacterDataProvider.characterSecrets.any((char) => char.name == charName.toLowerCase());
}

Character getCharacterElement(List<Character> characterList, String charName) {
  return characterList.firstWhere(
    (char) => char.name.toLowerCase().contains(charName),
    orElse: () => throw Exception("Character not found"),
  );
}

Character getCharacterSecretElement(String charName) {
  return CharacterDataProvider.characterSecrets.firstWhere(
    (char) => char.name.toLowerCase().contains(charName),
    orElse: () => throw Exception("Character not found"),
  );
}
