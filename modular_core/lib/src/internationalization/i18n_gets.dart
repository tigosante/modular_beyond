part of '../../modular_core.dart';

abstract class I18nGets {
  bool get isStarted;
  IgnoreDefaultsConfig get ignore;

  String get alias;
  String get fullPath;
  String get assetsPath;
  List<Locale> get supoortedLocales;

  I18nGets copyWith({
    String? alias,
    String? assetsPath,
    List<Locale>? supoortedLocales,
  });
}
