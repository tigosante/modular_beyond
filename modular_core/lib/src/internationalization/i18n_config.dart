part of '../../modular_core.dart';

abstract class I18nConfig implements I18n, I18nGets {}

class I18nConfigImpl implements I18nConfig {
  bool _isMainApp = false;
  bool _assetsIsSet = false;
  bool _localesIsSet = false;
  bool _moduleNameIsSet = false;
  IgnoreDefaultsConfig _ignoreDefault =
      IgnoreDefaultsConfig(assets: false, locales: false);

  String? _moduleAlias;
  String _moduleName = '';
  String _assetsPath = '';

  List<Locale> _supoortedLocales = [];

  @override
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return other is I18nConfigImpl && other.toString() == toString();
  }

  @override
  bool get isStarted =>
      _assetsIsSet ||
      _localesIsSet ||
      _moduleNameIsSet ||
      _ignoreDefault.isIgnore ||
      _isMainApp;

  @override
  IgnoreDefaultsConfig get ignore => _ignoreDefault;

  @override
  String get alias => _moduleAlias ?? _moduleName;

  @override
  List<Locale> get supoortedLocales => _supoortedLocales.toSet().toList();

  @override
  String get fullPath =>
      _isMainApp ? _getAssetsPath : 'packages/$_moduleName/$_getAssetsPath/';

  @override
  String get assetsPath => _getAssetsPath;

  String get _getAssetsPath =>
      (_assetsIsSet ? _assetsPath : assetsPathDefault).replaceAll('//', '/');

  @override
  void mainModule({
    List<Locale> supoortedLocales = const [],
    String assetsPath = assetsPathDefault,
    String alias = aliasMainModuleDefault,
    IgnoreDefaultsConfig? ignoreDefault,
  }) {
    assert(assetsPath.isNotEmpty, "Assets path can't be empty");
    _isMainApp = true;
    _moduleNameIsSet = true;
    _moduleAlias = alias;
    _assetsPath = assetsPath;
    _assetsIsSet = true;
    _supoortedLocales = supoortedLocales;
    _localesIsSet = true;
    _ignoreDefault = ignoreDefault ?? _ignoreDefault;
  }

  @override
  void module(
    String name, {
    List<Locale> supoortedLocales = const [],
    String assetsPath = assetsPathDefault,
    String? alias,
    IgnoreDefaultsConfig? ignoreDefault,
  }) {
    assert(name.isNotEmpty, "Module name can't be empty");
    assert(assetsPath.isNotEmpty, "Assets path can't be empty");
    _moduleName = name;
    _moduleNameIsSet = true;
    _moduleAlias = alias ?? name;
    _assetsPath = assetsPath;
    _assetsIsSet = true;
    _supoortedLocales = supoortedLocales;
    _localesIsSet = true;
    _ignoreDefault = ignoreDefault ?? _ignoreDefault;
  }

  @override
  String toString() {
    return '$fullPath/$_supoortedLocales';
  }

  @override
  I18nGets copyWith({
    String? alias,
    String? assetsPath,
    List<Locale>? supoortedLocales,
  }) {
    final assetsIsSet = assetsPath?.isNotEmpty ?? false;
    final localesIsSet = supoortedLocales?.isNotEmpty ?? false;

    return I18nConfigImpl()
      .._moduleAlias = alias ?? _moduleAlias
      .._assetsPath = assetsPath ?? _assetsPath
      .._supoortedLocales = supoortedLocales ?? _supoortedLocales
      //
      .._isMainApp = _isMainApp
      .._moduleName = _moduleName
      .._assetsIsSet = assetsIsSet
      .._localesIsSet = localesIsSet
      .._moduleNameIsSet = _moduleNameIsSet
      .._ignoreDefault = _ignoreDefault;
  }
}
