// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../generated/l10n.dart';
import '../../../styles/styles.dart';
import '../../../viewmodels/main_viewmodel.dart';

class SpeedDialPart extends StatelessWidget {
  const SpeedDialPart({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    final runningStatus = context.select<MainViewModel, RunningStatus>(
      (viewModel) => viewModel.runningStatus,
    );

    return runningStatus != RunningStatus.BEFORE_START
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.greenAccent,
              overlayColor: dialogBackgroundColor,
              children: [
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.donate),
                  label: S.of(context).donation,
                  labelBackgroundColor: speedDialLabelBackgroundColor,
                  onTap: _donate,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.ad),
                  label: S.of(context).deleteAd,
                  labelBackgroundColor: speedDialLabelBackgroundColor,
                  onTap: _deleteAd,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.subscript),
                  label: S.of(context).subscription,
                  labelBackgroundColor: speedDialLabelBackgroundColor,
                  onTap: _subscribe,
                ),
                SpeedDialChild(
                  child: const Icon(FontAwesomeIcons.undo),
                  label: S.of(context).recoverPurchase,
                  labelBackgroundColor: speedDialLabelBackgroundColor,
                  onTap: _recoverPurchase,
                ),
              ],
            ),
          );
  }

  ///
  void _donate() {}

  ///
  void _deleteAd() {}

  ///
  void _subscribe() {}

  ///
  void _recoverPurchase() {}
}
