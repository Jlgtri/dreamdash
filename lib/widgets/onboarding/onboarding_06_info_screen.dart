import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'onboarding_06_info_screen.g.dart';

@TypedGoRoute<Onboarding06InfoRoute>(
  path: '/onboarding/06_info',
)
class Onboarding06InfoRoute extends GoRouteData {
  const Onboarding06InfoRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding06InfoScreen();

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
class Onboarding06InfoScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding06InfoScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA06InfoEnUs i18n = I18N.of(context).onboarding.a06Info;
    final $SourceAssetsOnboarding06InfoGen assets =
        Assets.source.assets.onboarding.a06Info;

    final ScrollController scrollController = useScrollController();
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
                BaseEvent(
                  'onboarding_screen_5_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'thanks',
                    'answer': 'continue',
                  },
                ),
              );
          final Routes<RouteData>? route =
              await ref.read(onboardingProvider.notifier).next();
          if (context.mounted) {
            route?.go(context);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    final String name = ref.read(nameProvider);
    final EdgeInsets horizontalPadding = EdgeInsets.only(
      left: mediaQuery.padding.left + 24,
      right: mediaQuery.padding.right + 24,
    );
    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Container(
            height: 188,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 19,
                  left: 0 / 393 * mediaQuery.size.width,
                  child: SizedBox(
                    height: 169,
                    child: assets.vector4.svg(
                      width: mediaQuery.size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 86,
                  left: 301 / 393 * mediaQuery.size.width,
                  child: assets.star39.svg(),
                ),
                Positioned(
                  top: 128,
                  left: 99 / 393 * mediaQuery.size.width,
                  child: assets.star34.svg(),
                ),
                Positioned(
                  top: 32,
                  left: 99 / 393 * mediaQuery.size.width,
                  child: assets.star32.svg(),
                ),
                Positioned(
                  left: 85 / 393 * mediaQuery.size.width,
                  top: 60,
                  child: SizedBox(
                    width: 247,
                    child: Text(
                      i18n.header,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 42,
                    height: 77,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 7.04931640625,
                          left: 7.048828125,
                          child: Container(
                            width: 63.98591613769531,
                            height: 62.90140914916992,
                            decoration: const BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                              color: Color.fromRGBO(250, 205, 119, 1),
                              borderRadius: BorderRadius.all(
                                Radius.elliptical(
                                  63.98591613769531,
                                  62.90140914916992,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 78.08451080322266,
                            height: 77,
                            decoration: const BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                              color: Color.fromRGBO(
                                250,
                                205,
                                119,
                                0.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.elliptical(
                                  78.08451080322266,
                                  77,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 198 / 393 * mediaQuery.size.width,
                  top: 126,
                  child: Container(
                    width: 42,
                    height: 40.76,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
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
                  left: 354 / 393 * mediaQuery.size.width,
                  top: 99,
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
                  left: 164 / 393 * mediaQuery.size.width,
                  top: 126,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFFF1B8),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 236 / 393 * mediaQuery.size.width,
                  top: 31,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFFF1B8),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 157 / 393 * mediaQuery.size.width,
                  top: 8,
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
                  left: 61 / 393 * mediaQuery.size.width,
                  top: 76,
                  child: Container(
                    width: 29,
                    height: 28.15,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
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
                  top: 109,
                  child: Container(
                    width: 3,
                    height: 3,
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
        const SliverToBoxAdapter(child: SizedBox(height: 73)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              constraints: const BoxConstraints(
                minHeight: 350,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(text: i18n.thankYou),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: i18n.userName(name: name),
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            TextSpan(
                              text: '!',
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 48),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: i18n.motivationMessage,
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: i18n.motivationStat,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: i18n.motivationFact,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Text(
                    i18n.callToAction,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  i18n.footerNote,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
                const SizedBox(height: 12),
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
                      i18n.continueButton,
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
