import 'package:flutter/material.dart';
import 'package:test_minpro_meditation/models/ad_manager.dart';
import 'package:test_minpro_meditation/models/purchase_manager.dart';
import 'package:test_minpro_meditation/models/shared_prefs_repository.dart';
import 'package:test_minpro_meditation/models/sound_manager.dart';

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
}
