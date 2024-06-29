import 'package:flutter/foundation.dart';
import 'package:modular_beyond/modular_beyond.dart';

class GuardT extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    debugPrint(Modular.args.toString());
    return true;
  }
}
