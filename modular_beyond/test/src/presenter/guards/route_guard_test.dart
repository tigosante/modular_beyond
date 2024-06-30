import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_beyond/modular_beyond.dart';

void main() {
  test('instance', () async {
    final route = ChildRoute('/', child: (_) => Container());
    final redirect = await MyGuard().pos(route, ModularArguments.empty());
    expect(redirect, isA<RedirectRoute>());
  });
}

class MyGuard extends RouteGuard {
  MyGuard() : super(redirectTo: '/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return false;
  }
}
