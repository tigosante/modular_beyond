import 'package:flutter/foundation.dart';
import 'package:shared/shared.dart';

class GuardT extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    debugPrint(Modular.args.toString());
    return true;
  }
}
