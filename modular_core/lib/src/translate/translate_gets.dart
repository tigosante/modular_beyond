part of '../../modular_core.dart';

abstract class TranslateGets {
  bool get isStarted;
  IgnoreDefaultsConfig get ignoreDefault;

  String get alias;
  String get fullPath;
  String get assetsPath;
  List<Locale> get supoortedLocales;

  TranslateGets copyWith({
    String? alias,
    String? assetsPath,
    List<Locale>? supoortedLocales,
  });
}
