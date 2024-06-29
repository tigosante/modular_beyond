import 'package:flutter/cupertino.dart';
import 'package:modular_beyond/modular_beyond.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('route child', () {
    final route = ParallelRoute.child(
      '/',
      child: (_) => Container(),
      customTransition: CustomTransition(
        transitionBuilder: (_, anim1, anim2, child) => child,
      ),
    );
    expect(route.name, '/');
  });

  test('route empty', () {
    final route = ParallelRoute.empty();
    expect(route.name, '');
  });

  test('route copyWith', () {
    final route = ParallelRoute.module('/', module: MyModule2()).copyWith();
    expect(route.name, '/');
  });

  test('route addParent', () {
    final routeParent = ParallelRoute.empty().copyWith(name: '/parent');
    final route =
        ParallelRoute.empty().copyWith(name: '/').addParent(routeParent);
    expect(route.name, '/parent/');
  });
}

class MyModule extends Module {}

class MyModule2 extends Module {}
