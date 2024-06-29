import 'package:modular_core/src/translate/services/services.dart';

TranslateService? _translateService;

extension TranslateExtension on String {
  String translate([List<String> args = const []]) {
    if (_translateService == null) {
      throw Exception('--> TRANSLATE SERVICE NOT FOUND <--');
    }

    return _translateService!.translate(this, args);
  }
}

extension InstanceTranslateService on TranslateService {
  void setInstance() {
    _translateService = this;
  }
}
