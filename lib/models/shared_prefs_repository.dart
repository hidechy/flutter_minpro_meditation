// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

import '../data_models/user_settings.dart';

const PREF_KEY_IS_SKIP_INTRO = 'is_skip_intro';
const PREF_KEY_LEVEL_ID = 'level_id';
const PREF_KEY_THEME_ID = 'theme_id';
const PREF_KEY_TIME_MINUTES = 'time_minutes';

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

  ///
  Future<UserSettings> getUserSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return UserSettings(
      isSkipIntroScreen: prefs.getBool(PREF_KEY_IS_SKIP_INTRO) ?? false,
      levelId: prefs.getInt(PREF_KEY_LEVEL_ID) ?? 0,
      themeId: prefs.getInt(PREF_KEY_THEME_ID) ?? 0,
      timeMinutes: prefs.getInt(PREF_KEY_TIME_MINUTES) ?? 5,
    );
  }

  ///
  Future<void> setLevel({required int index}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PREF_KEY_LEVEL_ID, index);
  }
}
