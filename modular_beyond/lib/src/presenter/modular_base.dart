import 'package:flutter/widgets.dart';
import 'package:modular_beyond/modular_beyond.dart';
import 'package:modular_beyond/src/domain/usecases/bind_module.dart';
import 'package:modular_beyond/src/domain/usecases/get_translate_data.dart';
import 'package:modular_beyond/src/domain/usecases/replace_instance.dart';
import 'package:modular_beyond/src/domain/usecases/unbind_module.dart';
import 'package:modular_core/modular_core.dart';

import '../domain/usecases/dispose_bind.dart';
import '../domain/usecases/finish_module.dart';
import '../domain/usecases/get_arguments.dart';
import '../domain/usecases/get_bind.dart';
import '../domain/usecases/set_arguments.dart';
import '../domain/usecases/start_module.dart';
import 'errors/errors.dart';
import 'navigation/modular_route_information_parser.dart';
import 'navigation/modular_router_delegate.dart';

abstract class IModularBase {
  /// Finishes all trees(Modules).
  void destroy();

  // Responsible for starting the app.
  /// It should only be called once, but it should be the first
  /// method to be called before a route or bind lookup.
  void init(Module module);

  /// value is '/';
  String get initialRoute;

  /// Retrieves the ModularArguments instance.
  /// A ModularArguments is renewed every search for a new route.
  ModularArguments get args;

  /// Retrieves the IModularNavigator instance.
  /// By default the instance that controls all routes globally is returned,
  /// but this behavior can be replaced in ModularNavigator
  /// by a custom instance:
  ///
  /// Modular.navigatorDelegate = MyNavigatorDelegate();
  IModularNavigator get to;

  /// replaces the default ModularNavigator with a custom instance:
  /// Ideal for Unit Testing.
  /// Modular.navigatorDelegate = MyNavigatorDelegate()
  IModularNavigator? navigatorDelegate;

  /// Request an instance by [Type]
  B get<B extends Object>({String? key});

  /// Request an instance by [Type]
  /// <br>
  /// Return null if not found instance
  B? tryGet<B extends Object>({String? key});

  /// Dispose a bind by [Type]
  bool dispose<B extends Object>({String? key});

  /// Navigator 2.0 initializator: RouteInformationParser
  ModularRouteInformationParser get routeInformationParser;

  /// Navigator 2.0 initializator: RouterDelegate
  ModularRouterDelegate get routerDelegate;

  /// Navigator 2.0 initializator: RouterConfig
  RouterConfig<Object> get routerConfig;

  LocalizationsDelegate<LanguageService> get localizationsDelegate;

  /// Change the starting route path
  void setInitialRoute(String initialRoute);

  /// Change a list of NavigatorObserver objects
  void setObservers(List<NavigatorObserver> navigatorObservers);

  /// Change the navigatorKey
  void setNavigatorKey(GlobalKey<NavigatorState>? key);

  /// Change the navigatorKey
  void setArguments(dynamic arguments);

  /// Change the navigatorKey
  void bindModule(Module module);

  /// remove all module binds by name
  void unbindModule<T extends Module>({String? type});

  /// replace instance
  void replaceInstance<T>(T instance, {String? key});

  /// Set the default values for the translate service
  void setTranslateDefaults({
    String? assetsPath,
    List<Locale> supoortedLocales = const [],
  });

  @visibleForTesting
  String get initialRoutePath;
}

class ModularBase implements IModularBase {
  final DisposeBind disposeBind;
  final FinishModule finishModule;
  final GetBind getBind;
  final GetArguments getArguments;
  final SetArguments setArgumentsUsecase;
  final GetTranslateData getTranslateData;
  final StartModule startModule;
  final BindModule bindModuleUsecase;
  final UnbindModule unbindModuleUsecase;
  final ReplaceInstance replaceInstanceUsecase;
  final IModularNavigator navigator;
  @override
  final ModularRouteInformationParser routeInformationParser;
  @override
  final ModularRouterDelegate routerDelegate;

  @override
  IModularNavigator? navigatorDelegate;

  bool _moduleHasBeenStarted = false;

  String _initialRoutePath = '/';

  @visibleForTesting
  @override
  String get initialRoutePath => _initialRoutePath;

  ModularBase({
    required this.routeInformationParser,
    required this.routerDelegate,
    required this.disposeBind,
    required this.getArguments,
    required this.getTranslateData,
    required this.finishModule,
    required this.getBind,
    required this.startModule,
    required this.navigator,
    required this.setArgumentsUsecase,
    required this.bindModuleUsecase,
    required this.unbindModuleUsecase,
    required this.replaceInstanceUsecase,
  });

  @override
  void setTranslateDefaults({
    String? assetsPath,
    List<Locale>? supoortedLocales,
  }) {
    ModularLocalizationsDelegate.traslateDefault = TranslateConfigImpl()
        .copyWith(assetsPath: assetsPath, supoortedLocales: supoortedLocales);
  }

  @override
  bool dispose<B extends Object>({String? key}) =>
      disposeBind<B>(key).getOrElse((left) => false);

  @override
  B get<B extends Object>({String? key}) {
    return getBind<B>(key).getOrThrow();
  }

  @override
  B? tryGet<B extends Object>({String? key}) {
    return getBind<B>(key).getOrNull();
  }

  @override
  void destroy() {
    _localizationsDelegate.destroy();
    _moduleHasBeenStarted = false;
    finishModule();
  }

  @override
  void init(Module module) {
    if (!_moduleHasBeenStarted) {
      startModule(module).getOrThrow();
      printResolverFunc?.call('${module.runtimeType} started!');
      _moduleHasBeenStarted = true;
      final translateData = getTranslateData().getOrNull();
      if (translateData?.isNotEmpty ?? false) {
        _localizationsDelegate.translates.addAll(translateData!);
      }
    } else {
      throw ModuleStartedException(
        'Module ${module.runtimeType} is already started',
      );
    }
  }

  @override
  IModularNavigator get to => navigatorDelegate ?? navigator;

  @override
  ModularArguments get args =>
      getArguments().getOrElse((l) => ModularArguments.empty());

  @override
  LocalizationsDelegate<LanguageService> get localizationsDelegate =>
      _localizationsDelegate;

  final flags = ModularFlags();

  @override
  final String initialRoute = '/';

  final _localizationsDelegate = ModularLocalizationsDelegate();

  @override
  void setInitialRoute(String value) {
    _initialRoutePath = value;
  }

  @override
  void setNavigatorKey(GlobalKey<NavigatorState>? key) {
    routerDelegate.setNavigatorKey(key);
  }

  @override
  void setObservers(List<NavigatorObserver> navigatorObservers) {
    routerDelegate.setObservers(navigatorObservers);
  }

  @override
  void setArguments(dynamic data) {
    setArgumentsUsecase.call(args.copyWith(data: data));
  }

  @override
  late final RouterConfig<Object> routerConfig = RouterConfig<Object>(
    routerDelegate: routerDelegate,
    routeInformationParser: routeInformationParser,
    routeInformationProvider: PlatformRouteInformationProvider(
      // ignore: deprecated_member_use
      initialRouteInformation: const RouteInformation(location: '/'),
    ),
    backButtonDispatcher: RootBackButtonDispatcher(),
  );

  @override
  void bindModule(Module module) {
    bindModuleUsecase(module).getOrThrow();
  }

  @override
  void unbindModule<T extends Module>({String? type}) {
    unbindModuleUsecase.call<T>(type: type).getOrThrow();
  }

  @override
  void replaceInstance<T>(T instance, {String? key}) {
    replaceInstanceUsecase.call<T>(instance, key).getOrThrow();
  }
}
