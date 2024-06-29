import 'package:flutter_test/flutter_test.dart';
import 'package:modular_beyond/src/modular_beyond_module.dart';
import 'package:modular_beyond/src/presenter/modular_base.dart';

void main() {
  test('resolver injection (ModularBase)', () {
    expect(injector.get<IModularBase>(), isA<ModularBase>());
  });
}
