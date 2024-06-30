import 'package:flutter_test/flutter_test.dart';
import 'package:modular_beyond/modular_beyond.dart';

void main() {
  test('instance', () {
    final route = RedirectRoute('/@route', to: 'redirect_route').copyWith();
    expect(route.name, '/@route');
  });
}
