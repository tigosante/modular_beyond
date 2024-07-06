part of '../../modular_core.dart';

class IgnoreDefaultsConfig {
  IgnoreDefaultsConfig({
    required this.assets,
    required this.locales,
  });

  /// Returns true if both [assets] and [locales] are true.
  bool get isIgnore => assets || locales;

  /// Ignore assets path.
  bool assets;

  /// Ignore locales.
  bool locales;

  factory IgnoreDefaultsConfig.assets() {
    return IgnoreDefaultsConfig(assets: true, locales: false);
  }

  factory IgnoreDefaultsConfig.lcales() {
    return IgnoreDefaultsConfig(assets: false, locales: true);
  }
}
