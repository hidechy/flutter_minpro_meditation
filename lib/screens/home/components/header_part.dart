// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_meditation/common/constants.dart';

import '../../../common/widgets/ripple_widget.dart';
import '../../../data_models/user_settings.dart';
import '../../../generated/l10n.dart';
import '../../../styles/styles.dart';
import '../../../viewmodels/main_viewmodel.dart';
import '../home_screen.dart';

class HeaderPart extends StatelessWidget {
  HeaderPart({super.key, required this.userSettings});

  final UserSettings userSettings;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: levelItem()),
        Expanded(child: themeItem()),
        Expanded(child: timeItem()),
      ],
    );
  }

  ///
  Widget levelItem() {
    return Selector<MainViewModel, RunningStatus>(
      selector: (context, viewModel) => viewModel.runningStatus,
      builder: (context, runningStatus, child) {
        return RippleWidget(
          onTap: (runningStatus == RunningStatus.BEFORE_START ||
                  runningStatus == RunningStatus.FINISHED)
              ? _openLevelSettingDialog
              : _showSettingCannotToast,
          child: Column(
            children: [
              const Icon(FontAwesomeIcons.layerGroup),
              const SizedBox(height: 10),
              Text(levelsList[userSettings.levelId].levelName),
            ],
          ),
        );
      },
    );
  }

  ///
  Widget themeItem() {
    return Selector<MainViewModel, RunningStatus>(
      selector: (context, viewModel) => viewModel.runningStatus,
      builder: (context, runningStatus, child) {
        return RippleWidget(
          onTap: (runningStatus == RunningStatus.BEFORE_START ||
                  runningStatus == RunningStatus.FINISHED)
              ? _openThemeSettingDialog
              : _showSettingCannotToast,
          child: Column(
            children: [
              const Icon(FontAwesomeIcons.images),
              const SizedBox(height: 10),
              Text(meditationThemesList[userSettings.themeId].themeName),
            ],
          ),
        );
      },
    );
  }

  ///
  Widget timeItem() {
    return RippleWidget(
      onTap: () {},
      child: Column(
        children: [
          const Icon(FontAwesomeIcons.stopwatch),
          const SizedBox(height: 10),
          Selector<MainViewModel, String>(
            selector: (context, viewModel) => viewModel.remainingTimeString,
            builder: (context, remainingTimeString, child) {
              return Text(remainingTimeString);
            },
          ),
        ],
      ),
    );
  }

  ///
  void _openLevelSettingDialog() {}

  ///
  void _openThemeSettingDialog() {}

  ///
  void _showSettingCannotToast() {
    Fluttertoast.showToast(
      msg: S.of(_context).showSettingsAgain,
      backgroundColor: dialogBackgroundColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
