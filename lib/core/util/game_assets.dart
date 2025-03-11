import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';

class GameAssets {
  static late Image spriteSheet;

  static Future<void> init() async {
    spriteSheet = await loadImage('assets/images/starfox64_3.png');
  }

  static Future<Image> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List list = data.buffer.asUint8List();
    final Completer<Image> completer = Completer();
    
    decodeImageFromList(list, (Image img) {
      completer.complete(img);
    });

    return completer.future;
  }
}