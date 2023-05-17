import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_models/level.dart';
import '../data_models/meditation_theme.dart';
import '../data_models/meditation_time.dart';
import '../generated/l10n.dart';
import '../viewmodels/main_viewmodel.dart';

List<Level> levelsList = [];
List<MeditationTheme> meditationThemesList = [];
List<MeditationTime> meditationTimesList = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    levelsList = setLevels(context);
    meditationThemesList = setMeditationThemes(context);
    meditationTimesList = setMeditationTimes(context);

    final viewModel = context.read<MainViewModel>();
    Future(viewModel.getUserSettings);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(S.of(context).hold),
          ],
        ),
      ),
    );
  }

  ///
  List<Level> setLevels(BuildContext context) {
    return [
      Level(
        levelId: LEVEL_ID_EASY,
        levelName: S.of(context).levelEasy,
        explanation: S.of(context).levelSelectEasy,
        bellPath: 'assets/sounds/bells_easy.mp3',
        totalInterval: 12,
        inhaleInterval: 4,
        holdInterval: 4,
        exhaleInterval: 4,
      ),
      Level(
        levelId: LEVEL_ID_NORMAL,
        levelName: S.of(context).levelNormal,
        explanation: S.of(context).levelSelectNormal,
        bellPath: 'assets/sounds/bells_normal.mp3',
        totalInterval: 16,
        inhaleInterval: 4,
        holdInterval: 4,
        exhaleInterval: 8,
      ),
      Level(
        levelId: LEVEL_ID_MID,
        levelName: S.of(context).levelMid,
        explanation: S.of(context).levelSelectMid,
        bellPath: 'assets/sounds/bells_mid.mp3',
        totalInterval: 20,
        inhaleInterval: 4,
        holdInterval: 8,
        exhaleInterval: 8,
      ),
      Level(
        levelId: LEVEL_ID_HIGH,
        levelName: S.of(context).levelHigh,
        explanation: S.of(context).levelSelectHigh,
        bellPath: 'assets/sounds/bells_advanced.mp3',
        totalInterval: 28,
        inhaleInterval: 4,
        holdInterval: 16,
        exhaleInterval: 8,
      ),
    ];
  }

  ///
  List<MeditationTheme> setMeditationThemes(BuildContext context) {
    return [
      MeditationTheme(
        themeId: THEME_ID_SILENCE,
        themeName: S.of(context).themeSilence,
        imagePath: 'assets/images/silence.jpg',
      ),
      MeditationTheme(
        themeId: THEME_ID_CAVE,
        themeName: S.of(context).themeCave,
        imagePath: 'assets/images/cave.jpg',
        soundPath: 'assets/sounds/bgm_cave.mp3',
      ),
      MeditationTheme(
        themeId: THEME_ID_SPRING,
        themeName: S.of(context).themeSpring,
        imagePath: 'assets/images/spring.jpg',
        soundPath: 'assets/sounds/bgm_spring.mp3',
      ),
      MeditationTheme(
        themeId: THEME_ID_SUMMER,
        themeName: S.of(context).themeSummer,
        imagePath: 'assets/images/summer.jpg',
        soundPath: 'assets/sounds/bgm_summer.mp3',
      ),
      MeditationTheme(
        themeId: THEME_ID_AUTUMN,
        themeName: S.of(context).themeAutumn,
        imagePath: 'assets/images/autumn.jpg',
        soundPath: 'assets/sounds/bgm_autumn.mp3',
      ),
      MeditationTheme(
        themeId: THEME_ID_STREAM,
        themeName: S.of(context).themeStream,
        imagePath: 'assets/images/stream.jpg',
        soundPath: 'assets/sounds/bgm_stream.mp3',
      ),
      MeditationTheme(
        themeId: THEME_ID_WIND_BELLS,
        themeName: S.of(context).themeWindBell,
        imagePath: 'assets/images/wind_bell.jpg',
        soundPath: 'assets/sounds/bgm_wind_bell.mp3',
      ),
      MeditationTheme(
        themeId: THEME_ID_BONFIRE,
        themeName: S.of(context).themeBonfire,
        imagePath: 'assets/images/bonfire.jpg',
        soundPath: 'assets/sounds/bgm_bonfire.mp3',
      ),
    ];
  }

  ///
  List<MeditationTime> setMeditationTimes(BuildContext context) {
    return [
      MeditationTime(
        timeDisplayString: S.of(context).min5,
        timeMinutes: 5,
      ),
      MeditationTime(
        timeDisplayString: S.of(context).min10,
        timeMinutes: 10,
      ),
      MeditationTime(
        timeDisplayString: S.of(context).min15,
        timeMinutes: 15,
      ),
      MeditationTime(
        timeDisplayString: S.of(context).min20,
        timeMinutes: 20,
      ),
      MeditationTime(
        timeDisplayString: S.of(context).min30,
        timeMinutes: 30,
      ),
      MeditationTime(
        timeDisplayString: S.of(context).min60,
        timeMinutes: 60,
      ),
    ];
  }
}
