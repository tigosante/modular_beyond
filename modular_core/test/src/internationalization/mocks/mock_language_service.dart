import 'package:modular_core/src/internationalization/services/language_service.dart';

class MockLanguageService extends LanguageService {
  MockLanguageService({
    required super.locale,
    required super.i18nList,
    super.i18nDefault,
  });
}
