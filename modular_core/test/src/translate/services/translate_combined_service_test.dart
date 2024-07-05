import 'package:flutter/widgets.dart';
import 'package:modular_core/modular_core.dart';
import 'package:test/test.dart';

import '../mocks/mock_buildcontext.dart';
import '../mocks/mock_language_service.dart';

void main() {
  final context = MockBuildContext();
  final service = TranslateServiceImpl(() => context);
  LanguageService getLanguageService(List<TranslateGets> translates) =>
      MockLanguageService(
        translates: translates,
        locale: const Locale('en', 'US'),
      );

  group(
    'TranslateCombinedService >',
    () {
      const moduleKey = 'test_module';
      final moduleConfig = TranslateConfigImpl()
        ..module(moduleKey, supoortedLocales: [const Locale('en', 'US')]);

      group('setModuleConfig >', () {
        test(
          'Verify if module config have any value - [Throws Exception]',
          () => expect(service.getCurrentConfig, throwsA(isA<Exception>())),
        );

        test(
          'Verify if module config is set correctly',
          () {
            service.setModuleConfig(moduleConfig);
            expect(
              service.getCurrentConfig().toString(),
              equals(moduleConfig.toString()),
            );
          },
        );

        test(
          'Verify length of configs list [length: 1]',
          () {
            service.setModuleConfig(moduleConfig);
            final listConfigs = service.getConfigs();
            expect(listConfigs.length, equals(1));
          },
        );
      });

      group('disposeModuleConfig >', () {
        test(
          'Verify length of configs list [length: 0]',
          () {
            service.setModuleConfig(moduleConfig);
            service.disposeModuleConfig(moduleConfig);
            final listConfigs = service.getConfigs();
            expect(listConfigs.length, equals(0));
          },
        );
      });

      group('translate >', () {
        test(
          // ignore: lines_longer_than_80_chars
          'TranslateConfig Empty - should return a key not found message - {{key}} & {{${moduleConfig.alias}.key}}',
          () {
            expect(service.translate('key'), equals('{{key}}'));
            service.setModuleConfig(moduleConfig);
            expect(
              service.translate('key'),
              equals('{{${moduleConfig.alias}.key}}'),
            );
          },
        );
        test(
          // ignore: lines_longer_than_80_chars
          'BuildContext throw - should return a key not found message - {{${moduleConfig.alias}.key}}',
          () {
            final serviceError = TranslateServiceImpl(() => throw Exception(''))
              ..setModuleConfig(moduleConfig);
            expect(
              serviceError.translate('key'),
              equals('{{${moduleConfig.alias}.key}}'),
            );
          },
        );
        test(
          // ignore: lines_longer_than_80_chars
          'LanguageService return null - should return a key not found message - {{${moduleConfig.alias}.key}}',
          () {
            LanguageService.setTestInstance(getLanguageService([moduleConfig]));
            service.setModuleConfig(moduleConfig);
            expect(
              service.translate('key'),
              equals('{{${moduleConfig.alias}.key}}'),
            );
          },
        );
        test(
          // ignore: lines_longer_than_80_chars
          'should return a value',
          () {
            LanguageService.setTestInstance(getLanguageService([moduleConfig]));
            LanguageService.translateDataTest
              ..clear()
              ..addAll({
                moduleConfig.alias: {'key': 'key value'},
              });
            service.setModuleConfig(moduleConfig);
            expect(service.translate('key'), equals('key value'));
          },
        );
        test(
          // ignore: lines_longer_than_80_chars
          'should return a value with args',
          () {
            LanguageService.setTestInstance(getLanguageService([moduleConfig]));
            LanguageService.translateDataTest
              ..clear()
              ..addAll({
                moduleConfig.alias: {'key_args': 'key value %s'},
              });
            service.setModuleConfig(moduleConfig);
            expect(
              service.translate('key_args', ['args']),
              equals('key value args'),
            );
          },
        );
      });
    },
  );
}
