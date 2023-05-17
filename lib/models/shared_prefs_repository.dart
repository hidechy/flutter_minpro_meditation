// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY_IS_SKIP_INTRO = 'is_skip_intro';

class SharedPrefsRepository {
  ///
  Future<bool> skipIntro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PREF_KEY_IS_SKIP_INTRO, true);
  }

  ///
  Future<bool> isSkipIntroScreen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREF_KEY_IS_SKIP_INTRO) ?? false;
  }
}
