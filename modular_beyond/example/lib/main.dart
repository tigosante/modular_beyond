import 'package:flutter/material.dart';
import 'package:modular_beyond/modular_beyond.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Modular.setTranslateDefaults(
    assetsPath: "assets/languages",
    supoortedLocales: [const Locale('en', 'US'), const Locale('pt', 'BR')],
  );
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
