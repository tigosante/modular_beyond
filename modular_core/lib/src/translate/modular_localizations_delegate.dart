part of '../../modular_core.dart';

TranslateGets? _traslateDefault;

class ModularLocalizationsDelegate
    implements LocalizationsDelegate<LanguageService> {
  final List<TranslateGets> translates = [];

  // ignore: avoid_setters_without_getters
  static set traslateDefault(TranslateGets? value) {
    _traslateDefault = value;
  }

  List<Locale> get _supportedLocales {
    final locales = translates
        .map((element) => element.supoortedLocales)
        .expand((list) => list);
    return (_traslateDefault?.supoortedLocales ?? [])..addAll(locales);
  }

  @override
  bool isSupported(Locale locale) {
    return _supportedLocales.toSet().toList().contains(locale);
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
