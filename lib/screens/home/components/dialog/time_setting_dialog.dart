// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../styles/styles.dart';
import '../../../../viewmodels/main_viewmodel.dart';
import '../../home_screen.dart';

class TimeSettingDialog extends StatelessWidget {
  TimeSettingDialog({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final timeSelectButton = List.generate(
      meditationTimesList.length,
      (index) => TextButton(
        onPressed: () {
          _setTime(minutes: meditationTimesList[index].timeMinutes);

          Navigator.pop(context);
        },
        child: Text(
          meditationTimesList[index].timeDisplayString,
          style: timeSettingDialogTextStyle,
        ),
      ),
    );

    return SizedBox(
      height: 200 + 60,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(S.of(context).selectTime),
          const SizedBox(height: 8),
          Table(
            children: [
              TableRow(
                children: [
                  timeSelectButton[0],
                  timeSelectButton[1],
                  timeSelectButton[2],
                ],
              ),
              TableRow(
                children: [
                  timeSelectButton[3],
                  timeSelectButton[4],
                  timeSelectButton[5],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  void _setTime({required int minutes}) {
    final viewModel = _context.read<MainViewModel>();
    viewModel.setTime(minutes: minutes);

    Fluttertoast.showToast(
      msg: S.of(_context).timeAdjusted,
    );
  }
}
