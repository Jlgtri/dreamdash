import 'dart:math';

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

part 'onboarding_19_journey_screen.g.dart';

@TypedGoRoute<Onboarding19JourneyRoute>(
  path: '/onboarding/19_journey',
)
class Onboarding19JourneyRoute extends GoRouteData {
  const Onboarding19JourneyRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding19JourneyScreen();

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
class Onboarding19JourneyScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding19JourneyScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA19JourneyEnUs i18n =
        I18N.of(context).onboarding.a19Journey;
    final $SourceAssetsOnboarding19JourneyGen assets =
        Assets.source.assets.onboarding.a19Journey;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    // useMemoized(() {
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (final _) async => scrollController.scrollToBottom(),
    //   );
    // });

    Future<void> next() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_18_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'start_journey',
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

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: i18n.startYour),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.transformationJourney,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 86)),
        SliverPadding(
          padding: const EdgeInsets.only(left: 28, right: 20),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                height: 311,
                width: min(345, mediaQuery.size.width - 48),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 26.4521484375,
                      left: 12 /
                          (393 - 48) *
                          min(345, mediaQuery.size.width - 48),
                      child: SizedBox(
                        height: 243,
                        child: assets.vector.svg(
                          width: 310 /
                              (393 - 48) *
                              min(345, mediaQuery.size.width - 48),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      left: (min(345, mediaQuery.size.width - 48) / 2 -
                              (251.97 / 2)) /
                          (393 - 48) *
                          min(345, mediaQuery.size.width - 48),
                      top: 31,
                      child: Container(
                        width: 251.97,
                        height: 280,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: assets.a111.provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    ///
                    Positioned(
                      left: (54 - 24) /
                          (393 - 48) *
                          min(345, mediaQuery.size.width - 48),
                      top: 15.68,
                      child: Container(
                        width: 83,
                        height: 81.32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                assets.thehandholdingthelightbulb2.provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: (54 - 24) /
                              (393 - 48) *
                              min(345, mediaQuery.size.width - 48) -
                          3,
                      top: 0,
                      child: SizedBox(
                        width: 67,
                        height: 15.68,
                        child: Text(
                          i18n.productive,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),

                    ///
                    Positioned(
                      left: (205 - 24) /
                          (393 - 48) *
                          min(345, mediaQuery.size.width - 48),
                      top: 15.68,
                      child: Container(
                        width: 83,
                        height: 81.32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                assets.handdrawinganexitstrategy11.provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: (205 - 24) /
                              (393 - 48) *
                              min(345, mediaQuery.size.width - 48) +
                          268 -
                          205,
                      top: 0,
                      child: SizedBox(
                        width: 67,
                        height: 31.35,
                        child: Text(
                          i18n.lifeOrganised,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),

                    ///
                    Positioned(
                      left: (286 - 24) /
                          (393 - 48) *
                          min(345, mediaQuery.size.width - 48),
                      top: 207.70,
                      child: Container(
                        width: 83,
                        height: 81.32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: assets.thehandholdingtheplanet1.provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262 /
                          (393 - 48) *
                          min(345, mediaQuery.size.width - 48),
                      top: 187.12,
                      child: SizedBox(
                        width: 62,
                        height: 31.35,
                        child: Text(
                          i18n.fabulousChanges,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),

                    ///
                    Positioned(
                      left:
                          0 / (393 - 48) * min(345, mediaQuery.size.width - 48),
                      top: 207.70,
                      child: Container(
                        width: 83,
                        height: 81.32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: assets.handholdinganhourglassfortimetracking1
                                .provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0 /
                              (393 - 48) *
                              min(345, mediaQuery.size.width - 48) +
                          27,
                      top: 187.12,
                      child: SizedBox(
                        width: 62,
                        height: 31.35,
                        child: Text(
                          i18n.moreEnergetic,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 86)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: i18n.usersExperience,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.stressReduction),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.weeks,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.ofDailyUsage),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 86)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
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
