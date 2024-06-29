import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modular_beyond/modular_beyond.dart';

class AppWidget extends StatelessWidget {
  final alice = Alice();

  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.routerDelegate.setNavigatorKey(alice.getNavigatorKey());
    return MaterialApp.router(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: Modular.routerConfig,
      localizationsDelegates: [
        Modular.localizationsDelegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
