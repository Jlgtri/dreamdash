import 'package:catcher/catcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'generated/i18n.g.dart';

/// The route in the app.
enum Routes {
  /// The main navigation screen.
  ///
  /// **Can** be provided with [NavigationScreen] as an argument.
  _navigation(null),

  /// The navigation bar on main screen.
  ///
  /// **Can** be provided with [NavigationBarScreen] as an argument.
  _navigationBar(null, parent: _navigation),

  /// The home screen.
  ///
  /// **Can** be provided with [HomeScreen] as an argument.
  home(
    '/bar/home',
    parent: _navigationBar,
    key: PageStorageKey<String>('HomeScreen'),
  );

  /// The route in the app.
  const Routes(this._name, {this.parent, this.navigationParent, this.key})
      : assert(_name != '', 'Name should not be empty.');

  /// The name of this route.
  String get name => _name!;
  final String? _name;

  /// The parent of this route.
  final Routes? parent;

  /// The parent route to use in navigation.
  final Routes? navigationParent;

  /// The key for this route.
  final Key? key;

  /// Return the current route depending on app's state.
  static Future<Routes> current(final ProviderContainer container) async =>
      home;

  /// The current path of this route.
  String get path =>
      <String>[if (parent?._name != null) parent!.path, name].join('/');

  /// If this route is in navigation.
  bool get isNavigationBar => parent == _navigationBar;

  /// The children of this route.
  Iterable<Routes> get children => values.where((final _) => _.parent == this);

  /// The navigator key to pass to children of this route.
  GlobalKey<NavigatorState>? get navigatorKey {
    assert(
      children.isNotEmpty,
      'The navigator key can only be provided for the children.',
    );
    switch (this) {
      case _navigation:
        return Catcher.navigatorKey;
      case _navigationBar:
      case home:
    }
    return null;
  }

  RouteBase get _route => _name == null
      ? ShellRoute(
          navigatorKey: navigatorKey,
          pageBuilder: pageBuilder,
          builder: pageBuilder == null ? builder : null,
          routes: children.map((final _) => _._route).toList(growable: false),
        )
      : GoRoute(
          path: _name,
          pageBuilder: pageBuilder,
          builder: pageBuilder == null ? builder : null,
          redirect: redirect != null
              ? (final _, final __) async => (await redirect!(_, __))?.path
              : null,
          parentNavigatorKey: (navigationParent ?? parent)?.navigatorKey,
          routes: children.map((final _) => _._route).toList(growable: false),
        );

  /// Return the builder for the this route.
  Widget builder(
    final BuildContext context,
    final GoRouterState state, [
    final Widget? child,
  ]) {
    Object? extra = state.extra;
    if (extra is Map<Routes, Object?>) {
      extra = extra[this] ?? extra;
    }
    return const Scaffold();
  }

  /// Return the redirect for the this route.
  Future<Routes?> Function(BuildContext context, GoRouterState state)?
      get redirect => null;

  /// Return the redirect for the this route.
  Page<Object?> Function(
    BuildContext context,
    GoRouterState state, [
    Widget? child,
  ])? get pageBuilder => null;
}

/// The wrapper around [MaterialApp] to support hot reload.
@immutable
class RoutesApp extends HookConsumerWidget {
  /// The wrapper around [MaterialApp] to support hot reload.
  const RoutesApp(this.initialRoute, {super.key});

  /// The current app's route.
  final Routes initialRoute;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) =>
      MaterialApp.router(
        title: 'Dream Dash',
        debugShowCheckedModeBanner: false,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        routerConfig: GoRouter(
          initialLocation: initialRoute.name,
          navigatorKey: Routes._navigation.navigatorKey,
          routes: Routes.values
              .where((final _) => _.parent == Routes._navigation)
              .map((final _) => _._route)
              .toList(),
        ),
        // theme: ThemeData.from(
        //   useMaterial3: true,
        //   textTheme: defaultTextTheme,
        //   colorScheme: defaultColorScheme,
        // ).custom,
        builder: (final BuildContext context, final Widget? child) {
          final ThemeData theme = Theme.of(context);
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
            child: DefaultTextStyle(
              style: theme.textTheme.titleMedium ?? const TextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              child: child!,
            ),
          );
        },
      );

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties..add(EnumProperty<Routes>('initialRoute', initialRoute)),
      );
}
