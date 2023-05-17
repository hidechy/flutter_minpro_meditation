// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../generated/l10n.dart';
import '../../../styles/styles.dart';
import '../../../viewmodels/main_viewmodel.dart';

class StatusDisplayPart extends StatelessWidget {
  StatusDisplayPart({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final runningStatus = context.select<MainViewModel, RunningStatus>(
      (viewModel) => viewModel.runningStatus,
    );

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          _upperSmallText(runningStatus: runningStatus),
          style: statusUpperTextStyle,
        ),
        Selector<MainViewModel, int>(
          selector: (context, viewModel) => viewModel.intervalRemainingSeconds,
          builder: (context, intervalRemainingSeconds, child) {
            return Text(
              _lowerLargeText(
                runningStatus: runningStatus,
                intervalRemainingSeconds: intervalRemainingSeconds,
              ),
              style: statusLowerTextStyle,
            );
          },
        ),
      ],
    );
  }

  ///
  String _upperSmallText({required RunningStatus runningStatus}) {
    var displayText = '';

    switch (runningStatus) {
      case RunningStatus.BEFORE_START:
        displayText = '';
        break;
      case RunningStatus.ON_START:
        displayText = S.of(_context).startsIn;
        break;
      case RunningStatus.INHALE:
        displayText = S.of(_context).inhale;
        break;
      case RunningStatus.HOLD:
        displayText = S.of(_context).hold;
        break;
      case RunningStatus.EXHALE:
        displayText = S.of(_context).exhale;
        break;
      case RunningStatus.PAUSE:
        displayText = S.of(_context).pause;
        break;
      case RunningStatus.FINISHED:
        displayText = '';
        break;
    }

    return displayText;
  }

  ///
  String _lowerLargeText({
    required RunningStatus runningStatus,
    required int intervalRemainingSeconds,
  }) {
    var displayText = '';

    if (runningStatus == RunningStatus.BEFORE_START) {
    } else if (runningStatus == RunningStatus.FINISHED) {
      displayText = S.of(_context).finished;
    } else {
      displayText = intervalRemainingSeconds.toString();
    }

    return displayText;
  }
}
