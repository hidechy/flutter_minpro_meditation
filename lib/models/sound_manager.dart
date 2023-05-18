import 'package:just_audio/just_audio.dart';

class SoundManager {
  final AudioPlayer _bellPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();

  final AudioPlayer _gongPlayer = AudioPlayer();

  double bellVolume = 0.2;

  ///
  Future<void> prepareSounds({
    required String bellPath,
    required bool isNeedBgm,
    String? bgmPath,
  }) async {
    await _bellPlayer.setAsset(bellPath);
    await _bellPlayer.setLoopMode(LoopMode.one);
    await _bellPlayer.setVolume(bellVolume);

    if (isNeedBgm) {
      await _bgmPlayer.setAsset(bgmPath!);
      await _bgmPlayer.setLoopMode(LoopMode.one);
      await _bgmPlayer.setVolume(bellVolume);
    }
  }

  ///
  void startBgm({
    required String bellPath,
    required bool isNeedBgm,
    String? bgmPath,
  }) {
    _bellPlayer
      ..setVolume(bellVolume)
      ..seek(Duration.zero)
      ..play();

    _bgmPlayer
      ..seek(Duration.zero)
      ..play();
  }

  ///
  void stopBgm({required bool isNeedBgm}) {
    _bellPlayer.stop();
    if (isNeedBgm) {
      _bgmPlayer.stop();
    }
  }

  ///
  Future<void> ringFinalGong() async {
    await _gongPlayer.setAsset('assets/sounds/gong_sound.mp3');
    await _gongPlayer.setVolume(bellVolume);
    await _gongPlayer.play();
  }

  ///
  void changeVolume({required double newVolume}) {
    bellVolume = newVolume / 100;
    _bellPlayer.setVolume(bellVolume);

    _gongPlayer.setVolume(bellVolume);
  }

  ///
  void dispose() {
    _bellPlayer.dispose();
    _bgmPlayer.dispose();
    _gongPlayer.dispose();
  }
}
