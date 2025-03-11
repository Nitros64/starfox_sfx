import 'package:flutter/material.dart';
import 'package:starfox_sfx/core/util/file_utils.dart';

class VoiceList extends StatelessWidget {
  final Function(String) onPlayAudio;
  final List<String> voicesPath;

  const VoiceList({
    super.key,
    required this.onPlayAudio,
    required this.voicesPath,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: voicesPath.length,
    itemBuilder: (context, index) {
      final voice = voicesPath[index];
      return TextButton(
        onPressed: () => onPlayAudio(voice),
        style: buildTextStyle(),
        child: Text(
          getCleanName(voice),
          style: TextStyle(fontFamily: 'Chicago', fontSize: 16),
        ),
      );
    },
  );

  ButtonStyle buildTextStyle() => TextButton.styleFrom(
    side: BorderSide(color: Colors.blue, width: 2), // Borde azul de 2px
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Bordes redondeados
    ),
  );
}
