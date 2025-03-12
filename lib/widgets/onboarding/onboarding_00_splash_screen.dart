import 'dart:async';

import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../routes.dart';
import '../utils.dart';

part 'onboarding_00_splash_screen.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<Onboarding00SplashRoute>(path: '/onboarding/00_splash')
class Onboarding00SplashRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const Onboarding00SplashRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      state.extra! as Onboarding00SplashScreen;

  @override
  CustomTransitionPage<void> buildPage(
    final BuildContext context,
    final GoRouterState state,
  ) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: build(context, state),
    transitionsBuilder:
        (
          final BuildContext context,
          final Animation<double> animation,
          final Animation<double> secondaryAnimation,
          final Widget child,
        ) => FadeTransition(opacity: animation, child: child),
  );
}

/// The welcome screen of the onboarding flow.
class Onboarding00SplashScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding00SplashScreen({
    required this.animation,
    this.showFirst = const Duration(seconds: 2),
    this.curve = Curves.easeInOut,
    this.transitionDuration = const Duration(seconds: 1),
    this.showSecond = const Duration(seconds: 1),
    super.key,
  });

  /// The animation to display.
  final RiveFile animation;

  /// How much to show the first part.
  final Duration showFirst;

  /// How much time to animate the transition.
  final Curve curve;

  /// How much time to animate the transition.
  final Duration transitionDuration;

  /// How much to show the second part.
  final Duration showSecond;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final I18NOnboardingA00SplashEnUs i18n =
        I18N.of(context).onboarding.a00Splash;
    final $SourceAssetsOnboarding00SplashGen assets =
        Assets.source.assets.onboarding.a00Splash;

    final AnimationController animation = useAnimationController(
      duration: transitionDuration,
    );
    final ValueNotifier<double> opacity = useState(0);
    useMemoized(
      () => animation.addListener(
        () => opacity.value = curve.transform(animation.value),
      ),
    );

    unawaited(
      useMemoized(() async {
        final ProviderContainer container = ProviderScope.containerOf(context);
        await ref
            .read(analyticsProvider.notifier)
            .track(
              BaseEvent(
                'splash_screen_shown',
                eventProperties: <String, String>{'ob_type': 'quiz_1'},
              ),
            );
        await Future<void>.delayed(showFirst);
        await animation.forward();
        await Future<void>.delayed(showSecond);
        final Routes<RouteData> route = await Routes.current(container);
        if (context.mounted) {
          await route.pushReplacement(context);
        }
      }),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 85),
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: opacity.value,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 15 / 852 * mediaQuery.size.height,
                  left: 269 / (393 - 40) * (mediaQuery.size.width - 40),
                  child: assets.star34.svg(),
                ),
                Positioned(
                  top: 85 / 852 * mediaQuery.size.height,
                  left: 139 / (393 - 40) * (mediaQuery.size.width - 40),
                  child: assets.star35.svg(),
                ),
                Positioned(
                  top: 558 / 852 * mediaQuery.size.height,
                  left: 165 / (393 - 40) * (mediaQuery.size.width - 40),
                  child: assets.star36.svg(),
                ),
                Positioned(
                  left: 154 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 187 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 277 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 418 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 18 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 590 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 233 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 600 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 277 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 123 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 7.62,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 163 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 447 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 7.62,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 83 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 512 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 7.62,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 6 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 112 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 164 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 7 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: const StarBorder(innerRadiusRatio: 0.01),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 7.62,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 449 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 165 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 669 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.33,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 317 / (393 - 40) * (mediaQuery.size.width - 40),
                  top: 540 / 852 * mediaQuery.size.height,
                  child: Opacity(
                    opacity: 0.68,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Opacity(
            opacity: 1 - opacity.value,
            child: RiveAnimation.direct(this.animation),
          ),
          // Opacity(
          //   opacity: 1 - opacity.value,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       const SizedBox(width: 24),
          //       SimpleShadow(
          //         opacity: 0.1,
          //         offset: const Offset(12, 15),
          //         sigma: 4,
          //         child: assets.star31.svg(),
          //       ),
          //       const SizedBox(width: 14),
          //       Text.rich(
          //         TextSpan(
          //           children: <InlineSpan>[
          //             TextSpan(text: i18n.dream),
          //             TextSpan(
          //               text: i18n.dash,
          //               style: TextStyle(
          //                 color: theme.colorScheme.secondary,
          //               ),
          //             ),
          //           ],
          //         ),
          //         textAlign: TextAlign.center,
          //         style: theme.textTheme.headlineLarge
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //       const SizedBox(width: 24 * 3.5),
          //     ],
          //   ),
          // ),
          Opacity(
            opacity: opacity.value,
            child: SizedBox(
              height: 72.98,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 24),
                  SimpleShadow(
                    opacity: 0.1,
                    offset: const Offset(12, 15),
                    sigma: 4,
                    child: assets.star31.svg(),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(text: i18n.become),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.aStar,
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: i18n.you),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.deserve,
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: i18n.toBe),
                        ],
                        style: theme.textTheme.headlineLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(DiagnosticsProperty<RiveFile>('animation', animation))
          ..add(DiagnosticsProperty<Duration>('showFirst', showFirst))
          ..add(DiagnosticsProperty<Curve>('curve', curve))
          ..add(
            DiagnosticsProperty<Duration>(
              'transitionDuration',
              transitionDuration,
            ),
          )
          ..add(DiagnosticsProperty<Duration>('showSecond', showSecond)),
      );
}
