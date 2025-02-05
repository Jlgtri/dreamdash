import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

// import 'providers/provider_overrides.dart';
import 'generated/assets.gen.dart';
import 'generated/i18n.g.dart';
import 'providers/analytics.dart';
import 'providers/authorization.dart';
import 'routes.dart';
import 'widgets/onboarding/onboarding_00_splash_screen.dart';

void main() async {
  final Talker talker = TalkerFlutter.init(
    settings: TalkerSettings(),
  );
  await runZonedGuarded(
    () async {
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      await Future.wait(<Future<Object?>>[
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
        SystemChrome.setPreferredOrientations(<DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
      ]);
      final ProviderContainer container = ProviderContainer(
        overrides: await Future.wait(<Future<Override>>[$amplitude, $supabase]),
        observers: <ProviderObserver>[
          TalkerRiverpodObserver(
            settings: const TalkerRiverpodLoggerSettings(
              printProviderDisposed: true,
            ),
          ),
        ],
      );
      runApp(
        UncontrolledProviderScope(
          container: container,
          child: TranslationProvider(
            child: RoutesApp(
              Routes.onboarding00Splash,
              initialExtra: Onboarding00SplashScreen(
                animation: await RiveFile.asset(
                  Assets.source.assets.onboarding.a00Splash.dreamdash,
                ),
              ),
            ),
          ),
        ),
      );
      widgetsBinding
          .addPostFrameCallback((final _) => FlutterNativeSplash.remove());
    },
    (final Object error, final StackTrace stack) {
      talker.handle(error, stack, 'Uncaught app exception');
    },
  );
}
