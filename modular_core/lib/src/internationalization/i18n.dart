part of '../../modular_core.dart';

const aliasMainModuleDefault = 'main_module';
const assetsPathDefault = 'assets/langs';

abstract class I18n {
  /// **Set main app module configs**
  ///
  /// [supoortedLocales]
  /// - Set supported locales
  /// - ```locales: [Locale('en', 'US'), Locale('pt', 'BR')]```
  // ignore: lines_longer_than_80_chars
  /// - **The json that contains the translations must be named as the locale code in lowercase:** ```en-us.json, pt-br.json```
  ///
  /// [assetsPath]
  /// - Default is 'assets/langs'
  ///
  /// [alias]
  /// - Set alias for module
  /// - Default is 'main_module'
  // ignore: lines_longer_than_80_chars
  /// - It will be used as a key to save the translation data in the cache
  /// - ```alias: 'main'```
  ///
  /// [ignoreDefault]
  /// - Ignore default configuration
  ///
  void mainModule({
    List<Locale> supoortedLocales,
    String assetsPath = assetsPathDefault,
    String alias = aliasMainModuleDefault,
    IgnoreDefaultsConfig? ignoreDefault,
  });

  /// **Set module configs**
  ///
  /// [name]
  /// - Set module name
  /// - ```name: 'home_module'```
  ///
  /// [supoortedLocales]
  /// - Set supported locales
  /// - ```locales: [Locale('en', 'US'), Locale('pt', 'BR')]```
  // ignore: lines_longer_than_80_chars
  /// - **The json that contains the translations must be named as the locale code in lowercase:** ```en-us.json, pt-br.json```
  ///
  /// [assetsPath]
  /// - Default is 'assets/langs'
  ///
  /// [alias]
  /// - Set alias for module
  // ignore: lines_longer_than_80_chars
  /// - It will be used as a key to save the translation data in the cache
  /// - ```alias: 'home'```
  /// - If null, the module name will be used
  ///
  /// [ignoreDefault]
  /// - Ignore default configuration
  ///
  void module(
    String name, {
    List<Locale> supoortedLocales,
    String assetsPath = assetsPathDefault,
    String? alias,
    IgnoreDefaultsConfig? ignoreDefault,
  });
}
