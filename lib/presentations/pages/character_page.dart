import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfox_sfx/bloc/face_animation_bloc.dart';
import 'package:starfox_sfx/core/audio/just_sound_lib.dart';
import 'package:starfox_sfx/core/audio/nitros_sound_player.dart';
import 'package:starfox_sfx/core/util/character_audio_provider.dart';
import 'package:starfox_sfx/features/domain/entities/character.dart';
import 'package:starfox_sfx/presentations/widgets/character_face_widget.dart';
import 'package:starfox_sfx/presentations/widgets/character_voice_list.dart';

class CharacterPage extends StatefulWidget {
  final String characterName;
  static final NitrosSoundPlayer nsp = NitrosSoundPlayer(JustSoundLib()); // My library
  const CharacterPage({super.key, required this.characterName});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {   

  @override
  void initState() {
    super.initState();
    //CharacterPage.nsp.initState();
    //NitrosSoundPlayer.nsp.setOnDoneFunction(onDone: onDone, onPlaying: onPlaying);
    CharacterPage.nsp.setOnDoneFunction(onDone: onDone, onPlaying: onPlaying);
  }

  @override
  void dispose() {
    //CharacterPage.nsp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  
    return FutureBuilder<Character>(
        future: characterProvider.loadCharacter(nameCharacter: widget.characterName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.voices!.isEmpty) {
            return const Center(child: Text('No voices available'));
          }              
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.characterName, 
                style: TextStyle(fontFamily: 'Arwing', fontSize: 20),),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  CharacterFaceWidget(charData: snapshot.data as Character),
                  const SizedBox(height: 20),
                  Expanded(
                    child: VoiceList(
                        voicesPath: snapshot.data!.voices!,
                        onPlayAudio: _playAudio
                      ),
                  ),
                ],
              ),
            );
        },
      );    
  }

   void _playAudio(String filePath) async {
    CharacterPage.nsp.playAssets(filePath);
  }  

  onDone() {
    if(!mounted) return;
    context.read<FaceAnimationBloc>().add(const StopFaceAnimationEvent());
  }

  onPlaying() {
    if(!mounted) return;
    context.read<FaceAnimationBloc>().add(PlayFaceAnimationEvent());
  }
}