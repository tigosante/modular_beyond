import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_beyond/modular_beyond.dart';

void main() {
  test('instance', () {
    final route = WildcardRoute(child: (_) => Container());
    expect(route.name, '/**');
  });
}
