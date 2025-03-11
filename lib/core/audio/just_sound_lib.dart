import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'sound_music.dart';

class JustSoundLib implements SoundMusic {
  late AudioPlayer audioPlayer;
  StreamSubscription? _playerSubscription;
  //late String prefix;
  bool _loop = false;
  Duration? jduration;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _playerSubscription?.cancel();
    audioPlayer.dispose();
  }

  @override
  void play() async {
    await audioPlayer.play();
  }

  @override
  void playAssets(String path) async {    
    try {
      jduration = await audioPlayer.setAsset(path);
      await audioPlayer.play();
    } catch (e) {
      print("Error playing asset: $e");
    }
  }

  @override
  void playURL(String path) async {
    try {
      jduration = await audioPlayer.setUrl(path);
      await audioPlayer.play();
    } catch (e) {
      print("Error playing URL: $e");
    }
  }

  @override
  void pause() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }

  @override
  Future<void> stop() async{
    await audioPlayer.stop();
  }

  @override
  void repeat(bool flag) {
    _loop = flag;
    if (_loop) {
      audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  @override
  int getDuration() {
    return jduration!.inMicroseconds;
  }

  @override
  bool isPlaying() {
    return audioPlayer.playing;
  }

  @override
  void setOnDoneFunction({Function? onDone, Function? onPlaying}) {
    _playerSubscription?.cancel();
    
    _playerSubscription = audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.ready && onPlaying != null) {
        onPlaying();
      }
      if (state.processingState == ProcessingState.completed &&
          onDone != null) {
        onDone();
      }
    });
  } 
}
