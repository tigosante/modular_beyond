part of '../../modular_core.dart';

abstract class TranslateConfig implements Translate, TranslateGets {}

class TranslateConfigImpl implements TranslateConfig {
  bool _isMainApp = false;
  bool _assetsIsSet = false;
  bool _localesIsSet = false;
  bool _moduleNameIsSet = false;
  bool _isIgnoreDefault = false;

  String? _moduleAlias;
  String _moduleName = '';
  String _assetsPath = '';

  List<Locale> _supoortedLocales = [];

  @override
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return other is TranslateConfigImpl && other.toString() == toString();
  }

  @override
  bool get isStarted =>
      _assetsIsSet ||
      _localesIsSet ||
      _moduleNameIsSet ||
      _isIgnoreDefault ||
      _isMainApp;

  @override
  bool get isIgnoreDefault => _isIgnoreDefault;

  @override
  String get alias => _moduleAlias ?? _moduleName;

  @override
  List<Locale> get supoortedLocales => _supoortedLocales.toSet().toList();

  @override
  String get fullPath =>
      _isMainApp ? _getAssetsPath : '$_moduleName/$_getAssetsPath/';

  @override
  String get assetsPath => _getAssetsPath;

  String get _getAssetsPath =>
      (_assetsIsSet ? _assetsPath : assetsPathDefault).replaceAll('//', '/');

  @override
  void mainModule({
    List<Locale> supoortedLocales = const [],
    String assetsPath = assetsPathDefault,
    String alias = aliasMainModuleDefault,
    bool ignoreDefault = false,
  }) {
    assert(assetsPath.isNotEmpty, "Assets path can't be empty");
    _isMainApp = true;
    _moduleNameIsSet = true;
    _moduleAlias = alias;
    _assetsPath = assetsPath;
    _assetsIsSet = true;
    _supoortedLocales = supoortedLocales;
    _localesIsSet = true;
    _isIgnoreDefault = ignoreDefault;
  }

  @override
  void module(
    String name, {
    List<Locale> supoortedLocales = const [],
    String assetsPath = assetsPathDefault,
    String? alias,
    bool ignoreDefault = false,
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
    _isIgnoreDefault = ignoreDefault;
  }

  @override
  String toString() {
    return '$fullPath/$_supoortedLocales';
  }

  @override
  TranslateGets copyWith({
    String? alias,
    String? assetsPath,
    List<Locale>? supoortedLocales,
  }) {
    final assetsIsSet = assetsPath?.isNotEmpty ?? false;
    final localesIsSet = supoortedLocales?.isNotEmpty ?? false;

    return TranslateConfigImpl()
      .._moduleAlias = alias ?? _moduleAlias
      .._assetsPath = assetsPath ?? _assetsPath
      .._supoortedLocales = supoortedLocales ?? _supoortedLocales
      //
      .._isMainApp = _isMainApp
      .._moduleName = _moduleName
      .._assetsIsSet = assetsIsSet
      .._localesIsSet = localesIsSet
      .._moduleNameIsSet = _moduleNameIsSet
      .._isIgnoreDefault = _isIgnoreDefault;
  }
}
