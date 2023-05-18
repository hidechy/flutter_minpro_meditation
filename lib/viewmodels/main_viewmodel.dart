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
  int timeElapsedInOneCycle = 0;

  ///
  bool isTimerCanceled = false;

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

          await prepareSounds();

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
  Future<void> _startBgm() async {
    final levelId = userSettings.levelId;
    final themeId = userSettings.themeId;

    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? meditationThemesList[themeId].soundPath : null;

    final bellPath = levelsList[levelId].bellPath;

    await soundManager.startBgm(
      bellPath: bellPath,
      isNeedBgm: isNeedBgm,
      bgmPath: bgmPath,
    );
  }

  ///
  void _stopBgm() {
    final themeId = userSettings.themeId;

    final isNeedBgm = themeId != THEME_ID_SILENCE;

    soundManager.stopBgm(isNeedBgm: isNeedBgm);
  }

  ///
  void resumeMeditation() {
    _startMeditationTimer();
  }

  ///
  void resetMeditation() {
    runningStatus = RunningStatus.BEFORE_START;
    intervalRemainingSeconds = INITIAL_INTERVAL;
    remainingTimeSeconds = userSettings.timeMinutes * 60;
    timeElapsedInOneCycle = 0;
    notifyListeners();
  }

  ///
  void pauseMeditation() {
    isTimerCanceled = false;

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
    remainingTimeSeconds = _adjustMeditationTime(remainingTimeSeconds);

    notifyListeners();

    timeElapsedInOneCycle = 0;

    _evaluateStatus();

    _startBgm();

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        isTimerCanceled = false;

        remainingTimeSeconds -= 1;

        if (runningStatus != RunningStatus.BEFORE_START &&
            runningStatus != RunningStatus.ON_START &&
            runningStatus != RunningStatus.PAUSE) {
          _evaluateStatus();
        }

        if (runningStatus == RunningStatus.PAUSE) {
          timer.cancel();
          isTimerCanceled = true;
          _stopBgm();
        }

        notifyListeners();
      },
    );
  }

  ///
  int _adjustMeditationTime(int remainingTimeSeconds) {
    final totalInterval = levelsList[userSettings.levelId].totalInterval;

    final remainder = remainingTimeSeconds.remainder(totalInterval);

    if (remainder > (totalInterval / 2)) {
      return remainingTimeSeconds + (totalInterval - remainder);
    } else {
      return remainingTimeSeconds - remainder;
    }
  }

  ///
  void _evaluateStatus() {
    if (remainingTimeSeconds <= 0) {
      runningStatus = RunningStatus.FINISHED;
      return;
    }

    final inhaleInterval = levelsList[userSettings.levelId].inhaleInterval;
    final holdInterval = levelsList[userSettings.levelId].holdInterval;
    final totalInterval = levelsList[userSettings.levelId].totalInterval;

    if (timeElapsedInOneCycle >= 0 && timeElapsedInOneCycle < inhaleInterval) {
      runningStatus = RunningStatus.INHALE;
      intervalRemainingSeconds = inhaleInterval - timeElapsedInOneCycle;
    } else if (timeElapsedInOneCycle < inhaleInterval + holdInterval) {
      runningStatus = RunningStatus.HOLD;
      intervalRemainingSeconds =
          (inhaleInterval + holdInterval) - timeElapsedInOneCycle;
    } else if (timeElapsedInOneCycle < totalInterval) {
      runningStatus = RunningStatus.EXHALE;
      intervalRemainingSeconds = totalInterval - timeElapsedInOneCycle;
    }

    timeElapsedInOneCycle = (timeElapsedInOneCycle > totalInterval - 1)
        ? 0
        : timeElapsedInOneCycle += 1;
  }
}
