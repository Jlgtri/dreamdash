import 'package:amplitude_flutter/events/base_event.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/authorization.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'onboarding_01_welcome_screen.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<Onboarding01WelcomeRoute>(path: '/onboarding/01_welcome')
class Onboarding01WelcomeRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const Onboarding01WelcomeRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding01WelcomeScreen();

  @override
  CustomTransitionPage<void> buildPage(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: build(context, state),
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
class Onboarding01WelcomeScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding01WelcomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final I18NOnboardingA01WelcomeEnUs i18n =
        I18N.of(context).onboarding.a01Welcome;
    final $SourceAssetsOnboarding01WelcomeGen assets =
        Assets.source.assets.onboarding.a01Welcome;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async {
          await scrollController.scrollToBottom();

          if (defaultTargetPlatform == TargetPlatform.iOS) {
            await ref.read(analyticsProvider.notifier).track(
                  BaseEvent('att_popup_shown'),
                );
            final TrackingStatus status =
                await AppTrackingTransparency.requestTrackingAuthorization();
            await ref.read(analyticsProvider.notifier).track(
                  BaseEvent(
                    'att_popup_clicked',
                    eventProperties: <String, String>{
                      'answer': status.name,
                    },
                  ),
                );
          }
        },
      );
    });

    Future<void> next([Routes<RouteData>? route]) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_started',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'welcome',
                    'answer': switch (route) {
                      Routes.authorization01Prompt => 'haveAccount',
                      Routes.authorization01Prompt => 'privacy',
                      Routes.authorization01Prompt => 'terms',
                      _ => 'get_started',
                    },
                  },
                ),
              );
          if (route == null) {
            await ref.read(analyticsProvider.notifier).track(
                  BaseEvent('continue_with_anonymous_user'),
                );
            await ref.read(authorizationProvider.notifier).signInAnonymously();
            await ref.read(analyticsProvider.notifier).track(
                  BaseEvent('anonymous_user_account_success'),
                );
            route ??= await ref.read(onboardingProvider.notifier).next();
            if (context.mounted) {
              route?.go(context);
            }
          } else if (route == Routes.authorization01Prompt) {
            await ref.read(analyticsProvider.notifier).track(
                  BaseEvent('have_account_clicked'),
                );
            await ref.read(analyticsProvider.notifier).track(
                  BaseEvent(
                    'login_screen_shown',
                    eventProperties: <String, String>{'placement': 'login'},
                  ),
                );
            if (context.mounted) {
              await route.push(context);
            }
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    return Container(
      padding: mediaQuery.viewPadding + mediaQuery.viewInsets,
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        slivers: <Widget>[
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Container(
              height: 463,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      height: 274.74,
                      child: assets.vector5.svg(
                        width: mediaQuery.size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 330.9716491699219,
                    left: 0.9999999403953552,
                    child: SizedBox(
                      height: 131.03,
                      child: assets.vector6.svg(
                        width: mediaQuery.size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 67,
                    left: 240 / 393 * mediaQuery.size.width,
                    child: assets.star34.svg(),
                  ),
                  Positioned(
                    top: 69,
                    left: 79 / 393 * mediaQuery.size.width,
                    child: assets.star35.svg(),
                  ),
                  Positioned(
                    top: 362,
                    left: 285 / 393 * mediaQuery.size.width,
                    child: assets.star36.svg(),
                  ),
                  Positioned(
                    top: 275,
                    left: 333 / 393 * mediaQuery.size.width,
                    child: assets.star37.svg(),
                  ),
                  Positioned(
                    left: mediaQuery.size.width / 2 - 298 / 2,
                    top: 62,
                    child: Container(
                      width: 298,
                      height: 398,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: assets.girl.provider(),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 201,
                    left: 30 + mediaQuery.size.width / 2 - 298 / 2,
                    child: assets.star44.svg(),
                  ),
                  Positioned(
                    right: -144 / 2,
                    top: 62,
                    child: SizedBox(
                      width: 144,
                      height: 142,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 13,
                            top: 13,
                            child: Container(
                              width: 118,
                              height: 116,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFACD77),
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
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 144,
                              height: 142,
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
                    left: 138 / 393 * mediaQuery.size.width,
                    top: 79,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: const StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9 / 393 * mediaQuery.size.width,
                    top: 241,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: const StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 229 / 393 * mediaQuery.size.width,
                    top: 386,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: const StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: theme.colorScheme.secondary,
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 121 / 393 * mediaQuery.size.width,
                    top: 403,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
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
                    left: 273 / 393 * mediaQuery.size.width,
                    top: 126,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
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
                    top: 106,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: ShapeDecoration(
                        gradient: secondaryGradient,
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
                    left: 193 / 393 * mediaQuery.size.width,
                    top: 409,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 19 / 393 * mediaQuery.size.width,
                    top: 400,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 192 / 393 * mediaQuery.size.width,
                    top: 172,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 152 / 393 * mediaQuery.size.width,
                    top: 27,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 79,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          i18n.welcome,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: i18n.toYour,
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: i18n.dreamsFullfilling,
                                style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(text: i18n.app),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
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
                        i18n.getStarted,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge?.copyWith(
                          shadows: <BoxShadow>[buttonShadow],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: () async => next(Routes.authorization01Prompt),
                      child: Text(
                        i18n.iAlreadyHaveAnAccount,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: i18n.agreement.byContinuingYouAgree,
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(text: i18n.agreement.withOur),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.agreement.privacyPolicy,
                            style: theme.textTheme.labelSmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async =>
                                  next(Routes.authorization01Prompt),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: i18n.agreement.and),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.agreement.termsOfUse,
                            style: theme.textTheme.labelSmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async =>
                                  next(Routes.authorization01Prompt),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: 3,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
