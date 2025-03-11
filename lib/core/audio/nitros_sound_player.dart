import 'audio_state.dart';
import 'sound_music.dart';

class NitrosSoundPlayer {  
  final SoundMusic _soundlib;
  PlayerState _audioPlayerState = PlayerState.stopped;
  
  NitrosSoundPlayer(this._soundlib) {
    initState();
  }

  void initState() {
    _soundlib.initState();
    _audioPlayerState = PlayerState.stopped;
  }

  void dispose() {
    _soundlib.dispose();
    _audioPlayerState = PlayerState.completed;
  }

  void playAssets(String path) {
    _soundlib.playAssets(path);
    _audioPlayerState = PlayerState.playing;
  }

  void playURL(String path)  {
    _soundlib.playURL(path);
    _audioPlayerState = PlayerState.playing;
  }

  void pause()  {
     _soundlib.pause();
    _audioPlayerState = PlayerState.paused;
  }

  Future<void> stop() async {
    await _soundlib.stop();
    _audioPlayerState = PlayerState.stopped;
  }

  void repeat(bool flag) {
    _soundlib.repeat(flag);
  }

  int getDuration() => _soundlib.getDuration();

  PlayerState get state => _audioPlayerState;

  bool isPlaying() => _soundlib.isPlaying();  

  void setOnDoneFunction({Function? onDone, Function? onPlaying}) {
    _soundlib.setOnDoneFunction(onDone: onDone, onPlaying: onPlaying);
  }
}
