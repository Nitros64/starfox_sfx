import 'dart:ui';

import 'package:starfox_sfx/features/domain/entities/character_mouth.dart';

class MouthMapper {
  static Rect toRect(CharacterMouth mouth) {
    return Rect.fromLTWH(
      mouth.left.toDouble(),
      mouth.top.toDouble(),
      mouth.width.toDouble(),
      mouth.height.toDouble(),
    );
  }
  static CharacterMouth fromRect(Rect rect) {
    return CharacterMouth(
      left: rect.left.toInt(),
      top: rect.top.toInt(),
      width: rect.width.toInt(),
      height: rect.height.toInt(),
    );
  }
}