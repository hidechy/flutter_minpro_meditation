import 'dart:async';

import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../common/functions/functions.dart';
import '../data_models/meditation_theme.dart';
import '../data_models/user_settings.dart';
import '../models/ad_manager.dart';
import '../models/purchase_manager.dart';
import '../models/shared_prefs_repository.dart';
import '../models/sound_manager.dart';
import '../screens/home/home_screen.dart';

class MainViewModel extends ChangeNotifier {
  MainViewModel({
    required this.sharedPrefsRepository,
    required this.soundManager,
    required this.adManager,
    required this.purchaseManager,
  });

  final SharedPrefsRepository sharedPrefsRepository;
  final SoundManager soundManager;
  final AdManager adManager;
  final PurchaseManager purchaseManager;

  UserSettings userSettings = const UserSettings(
    isSkipIntroScreen: false,
    levelId: 0,
    themeId: 0,
    timeMinutes: 5,
  );

  int remainingTimeSeconds = 0;

  RunningStatus runningStatus = RunningStatus.BEFORE_START;

  ///
  String get remainingTimeString =>
      convertTimeFormat(seconds: remainingTimeSeconds);

  ///
  int intervalRemainingSeconds = INITIAL_INTERVAL;

  ///
  double volume = 0;

  ///
  Future<void> skipIntro() async {
    await sharedPrefsRepository.skipIntro();
  }

  ///
  Future<bool> isSkipIntroScreen() async {
    return sharedPrefsRepository.isSkipIntroScreen();
  }

  ///
  Future<void> getUserSettings() async {
    userSettings = await sharedPrefsRepository.getUserSettings();

    remainingTimeSeconds = userSettings.timeMinutes * 60;

    notifyListeners();
  }

  ///
  Future<void> setLevel({required int index}) async {
    await sharedPrefsRepository.setLevel(index: index);
    await getUserSettings();
  }

  ///
  Future<void> setTime({required int minutes}) async {
    await sharedPrefsRepository.setTime(minutes: minutes);
    await getUserSettings();
  }

  ///
  Future<void> setTheme({required int index}) async {
    await sharedPrefsRepository.setTheme(index: index);
    await getUserSettings();
  }

  ///
  void startMeditation() {
    runningStatus = RunningStatus.ON_START;
    notifyListeners();

    intervalRemainingSeconds = INITIAL_INTERVAL;

    var cnt = 0;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        cnt++;

        intervalRemainingSeconds = INITIAL_INTERVAL - cnt;

        if (intervalRemainingSeconds <= 0) {
          timer.cancel();

          //
          await prepareSounds();
          //

          _startMeditationTimer();
        } else if (runningStatus == RunningStatus.PAUSE) {
          timer.cancel();

          resetMeditation();
        }

        notifyListeners();
      },
    );
  }

  ///
  Future<void> prepareSounds() async {
    final levelId = userSettings.levelId;
    final themeId = userSettings.themeId;

    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? meditationThemesList[themeId].soundPath : null;

    final bellPath = levelsList[levelId].bellPath;

    await soundManager.prepareSounds(
      bellPath: bellPath,
      isNeedBgm: isNeedBgm,
      bgmPath: bgmPath,
    );
  }

  ///
  void resumeMeditation() {}

  ///
  void resetMeditation() {}

  ///
  void pauseMeditation() {
    runningStatus = RunningStatus.PAUSE;
    notifyListeners();
  }

  ///
  Future<void> changeVolume({required double newVolume}) async {
    volume = newVolume;
    notifyListeners();
  }

  ///
  void _startMeditationTimer() {
    runningStatus = RunningStatus.INHALE;
    notifyListeners();
  }
}
