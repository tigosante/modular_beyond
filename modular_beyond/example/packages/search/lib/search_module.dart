import 'dart:ui';

import 'package:search/presenter/pages/search_page.dart';
import 'package:shared/shared.dart';
import 'package:user_details/user_details.dart';

class SearchModule extends Module {
  @override
  void translate(Translate t) {
    // Funciona igual o método do mainModule, a diferença é que precisa passar o nome do package / module.
    t.module(
      "search", // nome do package / module para buscar.
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
    r.child('/', child: (_) => const SearchPage());
    r.module('/details', module: UserDetailsModule());
  }
}
