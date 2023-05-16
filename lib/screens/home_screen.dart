import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(S.of(context).hold),
          ],
        ),
      ),
    );
  }
}
