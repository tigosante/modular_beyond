import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart'
    show BuildContext, Locale, Localizations, debugPrint, visibleForTesting;
import 'package:modular_core/modular_core.dart';

class LanguageService {
  LanguageService({
    required Locale locale,
    required List<TranslateGets> translates,
    required TranslateGets? translateDefault,
  })  : _locale = locale,
        _translates = translates,
        _translateDefault = translateDefault;

  final Locale _locale;
  final List<TranslateGets> _translates;

  final TranslateGets? _translateDefault;

  static LanguageService? _testInstance;

  static final Map<String, Map<String, String>> _translateData = {};

  @visibleForTesting
  static final Map<String, Map<String, String>> translateDataTest = {};

  static LanguageService? of(BuildContext context) {
    if (_testInstance != null) {
      return _testInstance;
    }
    return Localizations.of<LanguageService>(context, LanguageService);
  }

  @visibleForTesting
  // ignore: use_setters_to_change_properties
  static void setTestInstance(LanguageService instance) {
    _testInstance = instance;
  }

  Map<String, String>? getTranslateJson(String key) {
    if (translateDataTest.isNotEmpty) {
      return translateDataTest[key];
    }
    return _translateData[key];
  }

  Future<bool> loadLanguages() async {
    _translateData.clear();

    return Future.wait(_getLocales().map(_loadData))
        .then((values) => values.reduce((value, element) => value || element))
        .catchError((_) => false);
  }

  List<TranslateGets> _getLocales() {
    if (_translateDefault == null) {
      return _translates;
    }

    return _translates
        .map(
          (config) => config.copyWith(
            assetsPath:
                config.ignore.assets ? null : _translateDefault?.assetsPath,
            supoortedLocales: config.ignore.locales
                ? null
                : _translateDefault?.supoortedLocales,
          ),
        )
        .toList();
  }

  Future<bool> _loadData(TranslateGets config) async {
    if (!config.supoortedLocales.toSet().toList().contains(_locale)) {
      return false;
    }

    final fileName = '${_locale.toLanguageTag().toLowerCase()}.json';
    final fullPath = '${config.fullPath}/$fileName'.replaceAll('//', '/');

    try {
      final jsonString = await rootBundle.loadString(fullPath);
      final Map<String, dynamic>? jsonMap = jsonDecode(jsonString);

      if (jsonMap == null) {
        return false;
      }

      _translateData.addAll({
        config.alias: jsonMap.map((key, value) => MapEntry(key, '$value')),
      });
      return true;
    } catch (e) {
      debugPrint('--> Error loading language file: $fullPath');
      return false;
    }
  }
}
