library modular_core;

import 'dart:async';

import 'package:characters/characters.dart';
import 'package:flutter/widgets.dart' show Locale, LocalizationsDelegate;
import 'package:meta/meta.dart';
import 'package:modular_core/modular_core.dart';
import 'package:modular_core/src/internationalization/supported_locales.dart';

export 'package:auto_injector/auto_injector.dart';
export 'package:modular_core/src/internationalization/services/language_service.dart';

export 'src/internationalization/extensions/extensions.dart';
export 'src/internationalization/services/services.dart';

// errors
part 'src/errors/errors.dart';
part 'src/internationalization/i18n.dart';
part 'src/internationalization/i18n_config.dart';
part 'src/internationalization/i18n_gets.dart';
part 'src/internationalization/ignore_defaults_config.dart';
// translate
part 'src/internationalization/modular_localizations_delegate.dart';
// di
part 'src/module/disposable.dart';
// modules
part 'src/module/module.dart';
// route
part 'src/route/arguments.dart';
part 'src/route/middleware.dart';
part 'src/route/route.dart';
part 'src/route/route_manager.dart';
part 'src/tracker.dart';

void Function(String text)? printResolverFunc;

void setPrintResolver(void Function(String text) fn) {
  printResolverFunc = fn;
}
