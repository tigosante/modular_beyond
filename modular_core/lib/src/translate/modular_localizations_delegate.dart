part of '../../modular_core.dart';

TranslateGets? _traslateDefault;

class ModularLocalizationsDelegate
    implements LocalizationsDelegate<LanguageService> {
  final List<TranslateGets> translates = [];

  // ignore: avoid_setters_without_getters
  static set traslateDefault(TranslateGets? value) {
    _traslateDefault = value;
  }

  List<Locale> get supportedLocales {
    return (translates
            .map((element) => element.supoortedLocales)
            .expand((list) => list)
            .toList()
          ..addAll(_traslateDefault?.supoortedLocales ?? []))
        .toSet()
        .toList();
  }

  @override
  bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  @override
  Future<LanguageService> load(Locale locale) async {
    final localizations = LanguageService(
      locale: locale,
      translates: translates,
      translateDefault: _traslateDefault,
    );
    await localizations.loadLanguages();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LanguageService> old) =>
      false;

  void destroy() {
    translates.clear();
    traslateDefault = null;
    supportedLocalesVariable.clear();
  }

  @override
  Type get type => LanguageService;
}
