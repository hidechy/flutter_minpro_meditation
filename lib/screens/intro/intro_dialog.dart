import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../generated/l10n.dart';

class IntroDialog extends StatelessWidget {
  const IntroDialog({super.key, required this.onSkipped});

  final VoidCallback onSkipped;

  ///
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSize.height / 6,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              S.of(context).skipIntroConfirm,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async => onSkipped(),
                child: Text(S.of(context).yes),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).no),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
