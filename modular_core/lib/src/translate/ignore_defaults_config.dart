part of '../../modular_core.dart';

class IgnoreDefaultsConfig {
  IgnoreDefaultsConfig({
    required this.ignoreAssets,
    required this.ignoreLocales,
  });

  /// Returns true if both [ignoreAssets] and [ignoreLocales] are true.
  bool get isIgnore => ignoreAssets && ignoreLocales;

  /// Ignore assets path.
  bool ignoreAssets;

  /// Ignore locales.
  bool ignoreLocales;

  factory IgnoreDefaultsConfig.assets() {
    return IgnoreDefaultsConfig(ignoreAssets: true, ignoreLocales: false);
  }

  factory IgnoreDefaultsConfig.lcales() {
    return IgnoreDefaultsConfig(ignoreAssets: false, ignoreLocales: true);
  }
}
