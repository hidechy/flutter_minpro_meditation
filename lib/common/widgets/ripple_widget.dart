import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class RippleWidget extends StatelessWidget {
  const RippleWidget({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  ///
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: touchFeedbackColor,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
