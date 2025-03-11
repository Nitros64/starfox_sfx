import 'package:flutter/material.dart';
import 'package:starfox_sfx/core/util/game_assets.dart';

class FaceAnimationPainter extends CustomPainter {
  //final ui.Image spritesheet;
  final Rect renderFaceSize;
  final Rect renderFace;
  final RRect? _ovalCorner;

  FaceAnimationPainter({
    //required this.spritesheet,
    required this.renderFace,
    required this.renderFaceSize,
    RRect? ovalCorner,
  }) : _ovalCorner = ovalCorner;

  @override
  void paint(Canvas canvas, Size size) {
    _radiusCanvas(canvas);
    canvas.drawImageRect(GameAssets.spriteSheet, renderFace, renderFaceSize, Paint());
  }

  _radiusCanvas(Canvas canvas) {
    if (_ovalCorner != null) {
      canvas.clipRRect(_ovalCorner);
    }
  }

  @override
  bool shouldRepaint(FaceAnimationPainter oldDelegate) {
    return oldDelegate.renderFace != renderFace;
  }
}
