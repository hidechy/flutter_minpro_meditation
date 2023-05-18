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
  Future<void> startBgm({
    required String bellPath,
    required bool isNeedBgm,
    String? bgmPath,
  }) async {
    await _bellPlayer.setVolume(bellVolume);
    await _bellPlayer.play();

    await _bgmPlayer.play();
  }
}
