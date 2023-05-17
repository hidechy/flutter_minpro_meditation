// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_meditation/styles/styles.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/ripple_widget.dart';
import '../../../viewmodels/main_viewmodel.dart';

class PlayButtonPart extends StatelessWidget {
  PlayButtonPart({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final runningStatus = context.select<MainViewModel, RunningStatus>(
      (viewModel) => viewModel.runningStatus,
    );

    return Stack(
      children: [
        Center(
          child: RippleWidget(
            onTap: () {
              _onPlayButtonPressed(runningStatus: runningStatus);
            },
            child: _largePlayIcon(runningStatus: runningStatus),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 8,
          child: (runningStatus == RunningStatus.PAUSE)
              ? RippleWidget(
                  onTap: _onStopButtonPressed,
                  child: const Icon(
                    FontAwesomeIcons.stop,
                    size: smallPlayButtonSize,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  ///
  Widget _largePlayIcon({required RunningStatus runningStatus}) {
    Icon icon;
    if (runningStatus == RunningStatus.BEFORE_START ||
        runningStatus == RunningStatus.PAUSE) {
      icon = const Icon(
        FontAwesomeIcons.play,
        size: largePlayButtonSize,
      );
    } else if (runningStatus == RunningStatus.FINISHED) {
      icon = const Icon(
        FontAwesomeIcons.stop,
        size: largePlayButtonSize,
      );
    } else {
      icon = const Icon(
        FontAwesomeIcons.pause,
        size: largePlayButtonSize,
      );
    }

    return icon;
  }

  ///
  void _onPlayButtonPressed({required RunningStatus runningStatus}) {
    final viewModel = _context.read<MainViewModel>();

    if (runningStatus == RunningStatus.BEFORE_START) {
      viewModel.startMeditation();
    } else if (runningStatus == RunningStatus.PAUSE) {
      viewModel.resumeMeditation();
    } else if (runningStatus == RunningStatus.FINISHED) {
      viewModel.resetMeditation();
    } else {
      viewModel.pauseMeditation();
    }
  }

  ///
  void _onStopButtonPressed() {
    final viewModel = _context.read<MainViewModel>();
    viewModel.resetMeditation();
  }
}
