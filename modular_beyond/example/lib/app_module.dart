import 'package:flutter/cupertino.dart';
import 'package:search/search_module.dart';
import 'package:shared/shared.dart';
import 'package:shared/shared_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];

  @override
  void translate(Translate t) {
    t.mainModule(
      assetsPath: "caso o path do app principal seja diferente do padrão",
      alias: "caso você queira ver o arquivo de tradução com um nome diferente",
      ignoreDefault: true, // você pode ignorar a configuração padrão.
      supoortedLocales: [
        const Locale('pt', 'BR')
      ], // caso queria passar um locale diferente do padrão
      // ou esse package ou main suportem locales diferentes.
    );
  }

  @override
  void routes(r) {
    r.module('/', module: SearchModule());
  }
}
