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