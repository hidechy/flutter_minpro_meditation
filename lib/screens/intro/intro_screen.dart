// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';

import '../../functions/functions.dart';
import '../../generated/l10n.dart';
import '../../viewmodels/main_viewmodel.dart';

import '../home_screen.dart';

import 'intro_dialog.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return IntroSlider(
      listContentConfig: [
        ContentConfig(
          title: S.of(context).introTitle1,
          description: S.of(context).introDesc1,
          pathImage: 'assets/images/intro_image01.png',
          backgroundColor: const Color(0xfff5a623),
        ),
        ContentConfig(
          title: S.of(context).introTitle2,
          description: S.of(context).introDesc2,
          pathImage: 'assets/images/intro_image02.png',
          backgroundColor: const Color(0xfff5a623),
        ),
        ContentConfig(
          title: S.of(context).introTitle3,
          description: S.of(context).introDesc3,
          pathImage: 'assets/images/intro_image03.png',
          backgroundColor: const Color(0xfff5a623),
        ),
        ContentConfig(
          title: S.of(context).introTitle4,
          description: S.of(context).introDesc4,
          pathImage: 'assets/images/meiso_logo.png',
          backgroundColor: const Color(0xfff5a623),
        ),
      ],
      onDonePress: goHomeScreen,
      onSkipPress: () {
        showModalDialog(
          context: context,
          dialogWidget: IntroDialog(
            onSkipped: () async {
              await context.read<MainViewModel>().skipIntro();

              goHomeScreen();
            },
          ),
          isScrollable: false,
        );
      },
    );
  }

  ///
  void goHomeScreen() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
