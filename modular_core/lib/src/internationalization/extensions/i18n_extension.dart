import 'package:modular_core/src/internationalization/services/services.dart';

I18nService? _service;

extension I18nExtension on String {
  String i18n([List<String> args = const []]) {
    _thorwIfServiceIsNull();
    return _service!.i18n(this, args);
  }

  String i18nMap(Map<String, String> data) {
    _thorwIfServiceIsNull();
    return _service!.i18nMap(this, data);
  }

  void _thorwIfServiceIsNull() {
    if (_service == null) {
      throw Exception('--> I18N SERVICE NOT FOUND <--');
    }
  }
}

extension InstanceI18nExtensionService on I18nService {
  void setInstance() {
    _service = this;
  }

  void removeInstance() {
    _service = null;
  }
}
