import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Modular.setTranslateDefaults(
    assetsPath: "assets/languages",
    supoortedLocales: [const Locale('en', 'US')],
  );
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
