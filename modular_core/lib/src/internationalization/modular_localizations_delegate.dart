part of '../../modular_core.dart';

I18nGets? _i18nDefault;

class ModularLocalizationsDelegate
    implements LocalizationsDelegate<LanguageService> {
  final List<I18nGets> i18nList = [];

  // ignore: avoid_setters_without_getters
  static set i18nDefault(I18nGets? value) {
    _i18nDefault = value;
  }

  List<Locale> get supportedLocales {
    return (i18nList
            .map((element) => element.supoortedLocales)
            .expand((list) => list)
            .toList()
          ..addAll(_i18nDefault?.supoortedLocales ?? []))
        .toSet()
        .toList();
  }

  @override
  bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  @override
  Future<LanguageService> load(Locale locale) async {
    final lanService = LanguageService(
      locale: locale,
      i18nList: i18nList,
      i18nDefault: _i18nDefault,
    );
    await lanService.loadLanguages();
    return lanService;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LanguageService> old) =>
      false;

  void destroy() {
    i18nList.clear();
    i18nDefault = null;
    supportedLocalesVariable.clear();
  }

  @override
  Type get type => LanguageService;
}
