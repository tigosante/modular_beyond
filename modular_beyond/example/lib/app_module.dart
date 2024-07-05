import 'package:search/search_module.dart';
import 'package:shared/shared.dart';
import 'package:shared/shared_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];

  @override
  void routes(r) {
    r.module('/', module: SearchModule());
  }
}
