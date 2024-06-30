import 'package:flutter_test/flutter_test.dart';
import 'package:modular_beyond/src/domain/dtos/route_dto.dart';

void main() {
  test('Equatable', () {
    expect(const RouteParmsDTO(url: '/'), const RouteParmsDTO(url: '/'));
    expect(const RouteParmsDTO(url: '/').hashCode,
        const RouteParmsDTO(url: '/').hashCode);
  });
}
