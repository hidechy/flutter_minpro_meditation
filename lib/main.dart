import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_meditation/screens/home_screen.dart';

import 'di/providers.dart';
import 'generated/l10n.dart';
import 'screens/intro/intro_screen.dart';
import 'viewmodels/main_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainViewModel>();

    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: FutureBuilder(
        future: viewModel.isSkipIntroScreen(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return const HomeScreen();
          } else {
            return IntroScreen();
          }
        },
      ),
    );
  }
}
