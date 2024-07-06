import 'dart:ui';

import 'package:modular_core/modular_core.dart';
import 'package:test/test.dart';

import '../mocks/mock_buildcontext.dart';
import '../mocks/mock_language_service.dart';

void main() {
  group(
    'I18nExtension >',
    () {
      group(
        'i18n >',
        () {
          test(
            'Should throw an exception if I18nService is null',
            () => expect(() => 'test'.i18n(), throwsA(isA<Exception>())),
          );
          test(
            'Should return a value with args',
            () {
              final moduleConfig = I18nConfigImpl()
                ..module(
                  'test_module',
                  supoortedLocales: [const Locale('en', 'US')],
                );
              LanguageService.setTestInstance(
                MockLanguageService(
                  i18nList: [moduleConfig],
                  locale: const Locale('en', 'US'),
                ),
              );
              LanguageService.dataTest
                ..clear()
                ..addAll({
                  moduleConfig.alias: {'test': 'key value %s'},
                });
              final service = I18nCombinedServiceImpl(MockBuildContext.new)
                ..setModuleConfig(moduleConfig);
              service.setInstance();
              expect('test'.i18n(['args']), equals('key value args'));
              service.removeInstance();
            },
          );
        },
      );
      group(
        'i18nMap >',
        () {
          test(
            'Should throw an exception if I18nService is null',
            () => expect(
              () => 'test'.i18nMap({'data': 'data'}),
              throwsA(isA<Exception>()),
            ),
          );
          test(
            'Should return a value',
            () {
              final moduleConfig = I18nConfigImpl()
                ..module(
                  'test_module',
                  supoortedLocales: [const Locale('en', 'US')],
                );
              LanguageService.setTestInstance(
                MockLanguageService(
                  i18nList: [moduleConfig],
                  locale: const Locale('en', 'US'),
                ),
              );
              LanguageService.dataTest
                ..clear()
                ..addAll({
                  moduleConfig.alias: {'test': 'key {{value}}'},
                });
              final service = I18nCombinedServiceImpl(MockBuildContext.new)
                ..setModuleConfig(moduleConfig);
              service.setInstance();
              expect(
                'test'.i18nMap({'value': 'value'}),
                equals('key value'),
              );
              service.removeInstance();
            },
          );
        },
      );
    },
  );
}
