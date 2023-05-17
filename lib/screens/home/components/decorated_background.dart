import 'package:flutter/material.dart';

import '../../../data_models/meditation_theme.dart';

class DecoratedBackground extends StatelessWidget {
  const DecoratedBackground({super.key, required this.theme});

  final MeditationTheme theme;

  ///
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black87, Colors.black26],
        ),
      ),
      child: Image.asset(
        theme.imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
