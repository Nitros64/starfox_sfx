
abstract class SoundMusic {
  void initState();
  void dispose();
  void play();
  void playURL(String path);
  void playAssets(String path);
  void repeat(bool flag);
  void pause();
  Future<void> stop();
  int getDuration();
  void setOnDoneFunction({Function? onDone, Function? onPlaying});
  bool isPlaying();
}
