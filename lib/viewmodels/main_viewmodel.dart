import 'package:flutter/material.dart';

import '../data_models/user_settings.dart';
import '../functions/functions.dart';
import '../models/ad_manager.dart';
import '../models/purchase_manager.dart';
import '../models/shared_prefs_repository.dart';
import '../models/sound_manager.dart';

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

  UserSettings? userSettings;

  int remainingTimeSeconds = 0;

  ///
  String get remainingTimeString =>
      convertTimeFormat(seconds: remainingTimeSeconds);

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
    userSettings = sharedPrefsRepository.getUserSettings() as UserSettings;

    remainingTimeSeconds = userSettings!.timeMinutes * 60;

    notifyListeners();
  }
}
