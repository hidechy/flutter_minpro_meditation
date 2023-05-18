// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/main_viewmodel.dart';

class VolumeSliderPart extends StatelessWidget {
  VolumeSliderPart({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final volume = context.select<MainViewModel, double>(
      (viewModel) => viewModel.volume,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Icon(Icons.volume_mute),
          Expanded(
            child: Slider(
              max: 100,
              inactiveColor: Colors.white.withOpacity(0.3),
              activeColor: Colors.white,
              value: volume,
              onChanged: (newVolume) {
                _changeVolume(newVolume: newVolume);
              },
              divisions: 100,
              label: volume.round().toString(),
            ),
          ),
          const Icon(Icons.volume_up),
        ],
      ),
    );
  }

  ///
  void _changeVolume({required double newVolume}) {
    final viewModel = _context.read<MainViewModel>();
    viewModel.changeVolume(newVolume: newVolume);
  }
}
