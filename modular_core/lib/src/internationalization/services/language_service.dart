import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart'
    show BuildContext, Locale, Localizations, debugPrint, visibleForTesting;
import 'package:modular_core/modular_core.dart';

class LanguageService {
  LanguageService({
    required Locale locale,
    required List<I18nGets> i18nList,
    I18nGets? i18nDefault,
  })  : _locale = locale,
        _i18nList = i18nList,
        _i18nDefault = i18nDefault;

  final Locale _locale;
  final List<I18nGets> _i18nList;

  final I18nGets? _i18nDefault;

  static LanguageService? _testInstance;

  static final Map<String, Map<String, String>> _data = {};

  @visibleForTesting
  static final Map<String, Map<String, String>> dataTest = {};

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

  Map<String, String>? getJson(String key) {
    if (dataTest.isNotEmpty) {
      return dataTest[key];
    }
    return _data[key];
  }

  Future<bool> loadLanguages() async {
    _data.clear();

    return Future.wait(_getLocales().map(_loadData))
        .then((values) => values.reduce((value, element) => value || element))
        .catchError((_) => false);
  }

  List<I18nGets> _getLocales() {
    if (_i18nDefault == null) {
      return _i18nList;
    }

    return _i18nList
        .map(
          (config) => config.copyWith(
            assetsPath: config.ignore.assets ? null : _i18nDefault?.assetsPath,
            supoortedLocales:
                config.ignore.locales ? null : _i18nDefault?.supoortedLocales,
          ),
        )
        .toList();
  }

  Future<bool> _loadData(I18nGets config) async {
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

      _data.addAll({
        config.alias: jsonMap.map((key, value) => MapEntry(key, '$value')),
      });
      return true;
    } catch (e) {
      debugPrint('--> Error loading language file: $fullPath');
      return false;
    }
  }
}
