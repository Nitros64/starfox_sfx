import 'package:flutter/material.dart';
import 'package:starfox_sfx/features/domain/entities/character_mouth.dart';
import 'package:starfox_sfx/features/domain/mapper/mouth_mapper.dart';
import 'package:starfox_sfx/presentations/widgets/face_animation_painter.dart';

class CharacterGridItem extends StatelessWidget {
  final CharacterMouth characterMouthIcon;
  final double width;
  final double height;
  final double radius;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;

  const CharacterGridItem({
    super.key,
    required this.characterMouthIcon,
    required this.width,
    required this.height,
    required this.radius,
    required this.onTap,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onDoubleTap: onDoubleTap,
    onTap: onTap,
    child: RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.orangeAccent, width: 1.0),
        ),
        child: _buildCustomPaint()
      ),
    ),
  );

  CustomPaint _buildCustomPaint() => CustomPaint(
    painter: FaceAnimationPainter(
      //spritesheet: GameAssets.spriteSheet,
      renderFace: MouthMapper.toRect(characterMouthIcon),
      renderFaceSize: Rect.fromLTWH(0, 0, width, height),
      ovalCorner: RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width * 0.98, height * 0.98),
        Radius.circular(radius),
      ),
    ),
  );
}
