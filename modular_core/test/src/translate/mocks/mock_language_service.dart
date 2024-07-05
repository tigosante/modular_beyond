import 'package:modular_core/src/translate/services/language_service.dart';

class MockLanguageService extends LanguageService {
  MockLanguageService({
    required super.locale,
    required super.translates,
    super.translateDefault,
  });
}
