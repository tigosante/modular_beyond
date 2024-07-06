part of '../../modular_core.dart';

abstract class ModularError implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ModularError(this.message, [this.stackTrace]);

  String _returnStackTrace() => stackTrace != null ? '\n$stackTrace' : '';

  @override
  String toString() => '$runtimeType: $message${_returnStackTrace()}';
}

class TrackerNotInitiated extends ModularError {
  const TrackerNotInitiated(
    String message, [
    StackTrace? stackTrace,
  ]) : super(message, stackTrace);
}

class I18nDataIsEmpty extends ModularError {
  const I18nDataIsEmpty([StackTrace? stackTrace])
      : super('i18n - data is empty', stackTrace);
}

class I18nCurrentKeyNotFound extends ModularError {
  const I18nCurrentKeyNotFound(this.currentKey, [StackTrace? stackTrace])
      : super('i18n - currentKey not found > key $currentKey', stackTrace);

  final String currentKey;
}

class I18nCurrentContextNotFound extends ModularError {
  const I18nCurrentContextNotFound(this.currentKey, [StackTrace? stackTrace])
      : super('i18n - context not found', stackTrace);

  final String currentKey;
}

class I18nCurrentDataNotFound extends ModularError {
  const I18nCurrentDataNotFound(this.currentKey, [StackTrace? stackTrace])
      : super('i18n - data not found > key: $currentKey', stackTrace);

  final String currentKey;
}
