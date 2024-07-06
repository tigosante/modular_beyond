import 'package:flutter/widgets.dart' show BuildContext, visibleForTesting;
import 'package:modular_core/modular_core.dart';

abstract class I18nCombinedService extends I18nService {
  void setModuleConfig(I18nConfig config);
  void disposeModuleConfig(I18nConfig config);

  @visibleForTesting
  I18nConfig getCurrentConfig();

  @visibleForTesting
  List<I18nConfig> getConfigs();
}

class I18nCombinedServiceImpl extends I18nCombinedService {
  I18nCombinedServiceImpl(this._getContext);

  final BuildContext Function() _getContext;

  final List<I18nConfig> _moduleConfigs = [];

  @override
  I18nConfig getCurrentConfig() {
    if (_moduleConfigs.isEmpty) {
      throw Exception('No module config found');
    }
    return _moduleConfigs.last;
  }

  @override
  List<I18nConfig> getConfigs() {
    return _moduleConfigs;
  }

  @override
  void setModuleConfig(I18nConfig config) {
    if (_moduleConfigs.lastOrNull != config) {
      _moduleConfigs.add(config);
    }
  }

  @override
  void disposeModuleConfig(I18nConfig config) {
    if (_moduleConfigs.lastOrNull == config) {
      _moduleConfigs.removeLast();
    }
  }

  @override
  String i18n(String key, [List<String> args = const []]) {
    try {
      var text = _getText(key);
      for (var index = 0; index < args.length; index++) {
        text = text.replaceFirst(RegExp('%s'), args[index]);
      }
      return text;
    } on I18nCurrentKeyNotFound catch (excpetion) {
      return '{{${excpetion.currentKey}}}';
    } on I18nCurrentContextNotFound catch (excpetion) {
      return '{{${excpetion.currentKey}}}';
    } on I18nCurrentDataNotFound catch (excpetion) {
      return '{{${excpetion.currentKey}}}';
    }
  }

  @override
  String i18nMap(String key, Map<String, String> data) {
    final map = data;
    if ((map..removeWhere((k, v) => k.isEmpty || v.isEmpty)).isEmpty) {
      throw const I18nDataIsEmpty();
    }

    try {
      var text = _getText(key);
      data.forEach(
        (key, value) => text = text.replaceAll(RegExp('{{$key}}'), value),
      );
      return text;
    } on I18nCurrentKeyNotFound catch (excpetion) {
      return '{{${excpetion.currentKey}}}';
    } on I18nCurrentContextNotFound catch (excpetion) {
      return '{{${excpetion.currentKey}}}';
    } on I18nCurrentDataNotFound catch (excpetion) {
      return '{{${excpetion.currentKey}}}';
    }
  }

  String _getText(String key) {
    late BuildContext context;
    if (_moduleConfigs.isEmpty) {
      throw I18nCurrentKeyNotFound(key, StackTrace.current);
    }

    final currentKey = _moduleConfigs.last.alias;
    try {
      context = _getContext();
    } catch (_, stackTrace) {
      throw I18nCurrentContextNotFound('$currentKey.$key', stackTrace);
    }

    final json = LanguageService.of(context)?.getJson(currentKey);
    if (json == null) {
      throw I18nCurrentDataNotFound('$currentKey.$key', StackTrace.current);
    } else if (json[key] case final String value) {
      return value;
    }

    throw I18nCurrentKeyNotFound('$currentKey.$key', StackTrace.current);
  }
}
