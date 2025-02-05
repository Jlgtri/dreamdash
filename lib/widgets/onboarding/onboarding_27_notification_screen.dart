import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'onboarding_27_notification_screen.g.dart';

@TypedGoRoute<Onboarding27NotificationRoute>(
  path: '/onboarding/27_notification',
)
class Onboarding27NotificationRoute extends GoRouteData {
  const Onboarding27NotificationRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding27NotificationScreen();

  @override
  CustomTransitionPage<void> buildPage(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: build(context, state),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (
          final BuildContext context,
          final Animation<double> animation,
          final Animation<double> secondaryAnimation,
          final Widget child,
        ) =>
            FadeTransition(opacity: animation, child: child),
      );
}

/// The welcome screen of the onboarding flow.
class Onboarding27NotificationScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding27NotificationScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA27NotificationEnUs i18n =
        I18N.of(context).onboarding.a27Notification;
    final $SourceAssetsOnboarding27NotificationGen assets =
        Assets.source.assets.onboarding.a27Notification;
    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> canContinue = useRef(false);
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    });

    Future<void> next() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent('notification_popup_shown'),
              );
          final PermissionStatus status =
              await Permission.notification.request();
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'notification_popup_clicked',
                  eventProperties: <String, Object?>{
                    'answer': status.name,
                  },
                ),
              );
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_26_clicked',
                  eventProperties: <String, Object?>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'notifications',
                    'answer': status.name,
                  },
                ),
              );
          if (status.isGranted ||
              status.isLimited ||
              status.isRestricted ||
              status.isPermanentlyDenied ||
              status.isProvisional) {
            final Routes<RouteData>? route =
                await ref.read(onboardingProvider.notifier).next();
            if (context.mounted) {
              route?.go(context);
            }
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverToBoxAdapter(
          child: Container(
            width: 393,
            height: 188,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 19,
                  left: 0,
                  child: SizedBox(
                    height: 169,
                    child: assets.vector4.svg(
                      width: mediaQuery.size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 111 / 393 * mediaQuery.size.width,
                  top: 35,
                  child: SizedBox(
                    width: 177,
                    child: Text(
                      i18n.remarkable,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -70 / 2,
                  top: 0,
                  child: SizedBox(
                    width: 78.08,
                    height: 77,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 138,
                          left: 37,
                          child: assets.star34.svg(),
                        ),
                        Positioned(
                          top: 146,
                          left: 126,
                          child: assets.star33.svg(),
                        ),
                        Positioned(
                          top: 54,
                          left: 105,
                          child: assets.star32.svg(),
                        ),
                        Positioned(
                          left: 7.05,
                          top: 7.05,
                          child: Container(
                            width: 63.99,
                            height: 62.90,
                            decoration: ShapeDecoration(
                              color: theme.colorScheme.secondary,
                              shape: const OvalBorder(),
                              shadows: const <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 78.08,
                            height: 77,
                            decoration: const ShapeDecoration(
                              color: Color(0x7FFACD77),
                              shape: OvalBorder(),
                              shadows: <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 301 / 393 * mediaQuery.size.width,
                  top: 70,
                  child: Container(
                    width: 42,
                    height: 40.76,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 9.14,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 359 / 393 * mediaQuery.size.width,
                  top: 112,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 7.62,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 334 / 393 * mediaQuery.size.width,
                  top: 48,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 75 / 393 * mediaQuery.size.width,
                  top: 121,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 7.62,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 61 / 393 * mediaQuery.size.width,
                  top: 76,
                  child: Container(
                    width: 29,
                    height: 28.15,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 6.31,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 287 / 393 * mediaQuery.size.width,
                  top: 33,
                  child: Container(
                    width: 23,
                    height: 22,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 7.62,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 25 / 393 * mediaQuery.size.width,
                  top: 109,
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: const ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 123 / 393 * mediaQuery.size.width,
                  top: 99,
                  child: SizedBox(
                    width: 146,
                    child: Text(
                      i18n.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 64)),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 178 / 393 * mediaQuery.size.width,
                  height: 178 / 393 * mediaQuery.size.width,
                  constraints: const BoxConstraints(
                    minWidth: 150,
                    maxWidth: 300,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          assets.happyvalentinesdaygreetingsandgift1.provider(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: i18n.notifications.turnOn,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.notifications.toGetResults,
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.notifications.motivationalTips,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.notifications.fromYourCoach,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 64)),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 450,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: theme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadows: const <BoxShadow>[buttonShadow],
                  ),
                  child: TextButton(
                    onPressed: next,
                    child: Text(
                      i18n.buttonText,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
