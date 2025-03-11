import 'package:starfox_sfx/features/domain/entities/character_mouth.dart';

class Character {
  late String name;
  late CharacterMouth mountClosed;
  late CharacterMouth mountOpen;
  late List<String>? voices;
  
  Character({
    required this.name, 
    required this.mountClosed, 
    required this.mountOpen, 
    required this.voices,
    //List<Voice>? oldVoices,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      mountClosed: CharacterMouth.fromJson(json['mountClosed']),
      mountOpen: CharacterMouth.fromJson(json['mountOpen']),
      //oldVoices: (json['voices'] as List).map((voice) => Voice.fromJson(voice)).toList(),
      voices: null
    );
  }
  factory Character.fromCharacter(Character char) {
    return Character(
      name: char.name,
      mountClosed: char.mountClosed,
      mountOpen: char.mountOpen,
      voices: null
    );
  }
}
