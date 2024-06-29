part of '../../modular_core.dart';

abstract class Module {
  List<Module> get imports => const [];

  void translate(Translate t) {}

  void binds(Injector i) {}
  void exportedBinds(Injector i) {}

  void routes(RouteManager r) {}
}
