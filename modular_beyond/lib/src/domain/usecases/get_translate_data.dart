import 'package:modular_core/modular_core.dart';
import 'package:result_dart/result_dart.dart';

import '../services/module_service.dart';

abstract class GetTranslateData {
  Result<List<TranslateGets>, ModularError> call();
}

class GetTranslateDataImpl implements GetTranslateData {
  final ModuleService moduleService;

  GetTranslateDataImpl(this.moduleService);

  @override
  Result<List<TranslateGets>, ModularError> call() {
    return moduleService.getTranslateData();
  }
}
