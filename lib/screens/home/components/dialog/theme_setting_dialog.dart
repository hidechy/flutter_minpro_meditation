// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_meditation/viewmodels/main_viewmodel.dart';

import '../../../../common/widgets/ripple_widget.dart';
import '../../../../generated/l10n.dart';
import '../../home_screen.dart';

class ThemeSettingDialog extends StatelessWidget {
  ThemeSettingDialog({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 50),
            Text(
              S.of(context).selectTheme,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  meditationThemesList.length,
                  (index) => RippleWidget(
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            meditationThemesList[index].themeName,
                          ),
                        ),
                      ),
                      child: Image.asset(
                        meditationThemesList[index].imagePath,
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {
                      _setTheme(index: index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 50,
          right: 30,
          child: RippleWidget(
            child: const Icon(Icons.close),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  ///
  void _setTheme({required int index}) {
    final viewModel = _context.read<MainViewModel>();
    viewModel.setTheme(index: index);
  }
}
