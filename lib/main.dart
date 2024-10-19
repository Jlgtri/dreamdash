import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'providers/provider_overrides.dart';
import 'generated/i18n.g.dart';
import 'routes.dart';

void main() => Catcher(
      runAppFunction: () async {
        final WidgetsBinding widgetsBinding =
            WidgetsFlutterBinding.ensureInitialized();
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
        final ProviderContainer container = ProviderContainer(
            // overrides: (await overrides).toList(),
            );
        try {
          await Future.wait(<Future<Object?>>[
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
            SystemChrome.setPreferredOrientations(<DeviceOrientation>[
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]),
          ]);
        } on Exception catch (error, stackTrace) {
          Catcher.reportCheckedError(error, stackTrace);
        }
        runApp(
          UncontrolledProviderScope(
            container: container,
            child: TranslationProvider(
              child: RoutesApp(await Routes.current(container)),
            ),
          ),
        );
        widgetsBinding
            .addPostFrameCallback((final _) => FlutterNativeSplash.remove());
      },
    );
