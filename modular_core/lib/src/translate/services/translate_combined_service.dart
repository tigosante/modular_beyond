import 'package:flutter/widgets.dart' show BuildContext;
import 'package:modular_core/modular_core.dart' show TranslateConfig;
import 'package:modular_core/src/translate/services/language_service.dart';
import 'package:modular_core/src/translate/services/translate_service.dart';

abstract class TranslateCombinedService extends TranslateService {
  void setModuleConfig(TranslateConfig config);
  void disposeModuleConfig(TranslateConfig config);
}

class TranslateServiceImpl extends TranslateCombinedService {
  TranslateServiceImpl(this._getContext);

  final BuildContext? Function() _getContext;

  final List<TranslateConfig> _moduleConfigs = [];

  @override
  void disposeModuleConfig(TranslateConfig config) {
    if (_moduleConfigs.lastOrNull == config) {
      _moduleConfigs.removeLast();
    }
  }

  @override
  void setModuleConfig(TranslateConfig config) {
    if (_moduleConfigs.lastOrNull != config) {
      _moduleConfigs.add(config);
    }
  }

  @override
  String translate(String key, [List<String> args = const []]) {
    String errorMessage(String currentKey) =>
        currentKey.isEmpty ? '{{$key}}' : '{{$currentKey.$key}}';
    final currentKey = _moduleConfigs.last.alias;
    BuildContext? context;

    try {
      context = _getContext();
    } catch (e) {
      return errorMessage(currentKey);
    }
    if (context == null) {
      return errorMessage(currentKey);
    }

    final data = LanguageService.of(context)?.getTranslateJson(currentKey);
    if (data == null || data[key] == null) {
      return errorMessage(currentKey);
    }

    var value = data[key]!;
    for (var index = 0; index < args.length; index++) {
      value = value.replaceFirst('%s', args[index]);
    }
    return value;
  }
}
