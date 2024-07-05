import 'package:modular_beyond_example/presenter/pages/not_found_page.dart';
import 'package:search/search_module.dart';
import 'package:shared/shared.dart';
import 'package:shared/shared_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];

  @override
  void translate(Translate t) {
    t.mainModule(
      assetsPath: 'assets/langs',
      ignoreDefault: IgnoreDefaultsConfig.assets(),
    );
  }

  @override
  void routes(r) {
    r.module('/', module: SearchModule());
    r.wildcard(child: (context) => const NotFoundPage());
  }
}
