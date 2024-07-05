import 'dart:ui';

import 'package:modular_core/modular_core.dart';
import 'package:test/test.dart';

import '../mocks/mock_buildcontext.dart';
import '../mocks/mock_language_service.dart';

void main() {
  group(
    'TranslateExtension >',
    () {
      group(
        'translate >',
        () {
          test(
            'Should throw an exception if TranslateService is null',
            () => expect(() => 'test'.translate(), throwsA(isA<Exception>())),
          );
          test(
            'Should return a value with args',
            () {
              final moduleConfig = TranslateConfigImpl()
                ..module(
                  'test_module',
                  supoortedLocales: [const Locale('en', 'US')],
                );
              LanguageService.setTestInstance(
                MockLanguageService(
                  translates: [moduleConfig],
                  locale: const Locale('en', 'US'),
                ),
              );
              LanguageService.translateDataTest
                ..clear()
                ..addAll({
                  moduleConfig.alias: {'test': 'key value %s'},
                });
              final service = TranslateServiceImpl(MockBuildContext.new)
                ..setModuleConfig(moduleConfig);
              service.setInstance();
              expect('test'.translate(['args']), equals('key value args'));
            },
          );
        },
      );
    },
  );
}
