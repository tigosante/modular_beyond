import 'package:modular_core/modular_core.dart';
import 'package:result_dart/result_dart.dart';

import '../services/module_service.dart';

abstract class GetI18nData {
  Result<List<I18nGets>, ModularError> call();
}

class GetI18nDataImpl implements GetI18nData {
  final ModuleService moduleService;

  GetI18nDataImpl(this.moduleService);

  @override
  Result<List<I18nGets>, ModularError> call() {
    return moduleService.getI18nData();
  }
}
