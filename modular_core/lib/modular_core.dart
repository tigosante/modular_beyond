library modular_core;

import 'dart:async';

import 'package:characters/characters.dart';
import 'package:flutter/widgets.dart' show Locale, LocalizationsDelegate;
import 'package:meta/meta.dart';
import 'package:modular_core/modular_core.dart';
import 'package:modular_core/src/translate/supported_locales.dart';

export 'package:auto_injector/auto_injector.dart';
export 'package:modular_core/src/translate/services/language_service.dart';

export 'src/translate/extensions/extensions.dart';
export 'src/translate/services/services.dart';

// errors
part 'src/errors/errors.dart';
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
// translate
part 'src/translate/modular_localizations_delegate.dart';
part 'src/translate/translate.dart';
part 'src/translate/translate_config.dart';
part 'src/translate/translate_gets.dart';

void Function(String text)? printResolverFunc;

void setPrintResolver(void Function(String text) fn) {
  printResolverFunc = fn;
}
