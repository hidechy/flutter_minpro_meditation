// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_meditation/viewmodels/main_viewmodel.dart';

import '../../../../generated/l10n.dart';
import '../../home_screen.dart';

class LevelSettingDialog extends StatelessWidget {
  LevelSettingDialog({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Column(
      children: [
        const SizedBox(height: 8),
        Text(S.of(context).selectLevel),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: levelsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: Text(levelsList[index].levelName),
              ),
              subtitle: Center(
                child: Text(levelsList[index].explanation),
              ),
              onTap: () {
                _setLevel(index: index);

                Navigator.pop(context);
              },
            );
          },
        ),
      ],
    );
  }

  ///
  void _setLevel({required int index}) {
    final viewModel = _context.read<MainViewModel>();
    viewModel.setLevel(index: index);
  }
}
