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

part 'onboarding_18_comparison_screen.g.dart';

@TypedGoRoute<Onboarding18ComparisonRoute>(
  path: '/onboarding/18_comparison',
)
class Onboarding18ComparisonRoute extends GoRouteData {
  const Onboarding18ComparisonRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding18ComparisonScreen();

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
class Onboarding18ComparisonScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding18ComparisonScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA18ComparisonEnUs i18n =
        I18N.of(context).onboarding.a18Comparison;
    final $SourceAssetsOnboarding18ComparisonGen assets =
        Assets.source.assets.onboarding.a18Comparison;

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
                  'onboarding_screen_17_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'difference',
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

    return Container(
      padding: mediaQuery.viewPadding + mediaQuery.viewInsets,
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        slivers: <Widget>[
          const SliverToBoxAdapter(child: SizedBox(height: 71)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: i18n.seeTheDifferenceWith),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: i18n.dreamdash,
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
          const SliverToBoxAdapter(child: SizedBox(height: 42)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 540,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: 1,
                      child: Container(
                        width: 170 / (393 - 48) * (mediaQuery.size.width - 48),
                        height: 539,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 36,
                              left: 9 / 393 * mediaQuery.size.width,
                              child: Opacity(
                                opacity: 1,
                                child: assets.vector.svg(),
                              ),
                            ),
                            Positioned(
                              top: 39.87939453125,
                              left: 106.58203125 / 393 * mediaQuery.size.width,
                              child: assets.star34.svg(),
                            ),
                            Positioned(
                              top: 67.8056640625,
                              left: 43.572265625 / 393 * mediaQuery.size.width,
                              child: assets.star34.svg(),
                            ),
                            Positioned(
                              top: 18.36083984375,
                              left: 43.572265625 / 393 * mediaQuery.size.width,
                              child: assets.star32.svg(),
                            ),
                            Positioned(
                              left: 77.05 / 393 * mediaQuery.size.width,
                              top: 66.78,
                              child: Container(
                                width: 2.06,
                                height: 2.06,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                  shape: const OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 73.45 / 393 * mediaQuery.size.width,
                              top: 6,
                              child: Container(
                                width: 18.04,
                                height: 17.51,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.04,
                                  ),
                                  shadows: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 7.20,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 59 / 393 * mediaQuery.size.width,
                              top: 40,
                              child: Container(
                                width: 18.04,
                                height: 17.51,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.04,
                                  ),
                                  shadows: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 7.20,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6 / 393 * mediaQuery.size.width,
                              top: 94,
                              child: SizedBox(
                                width: 117,
                                child: Text(
                                  i18n.without,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 8 / 393 * mediaQuery.size.width,
                              top: 142.50,
                              child: SizedBox(
                                width: mediaQuery.size.width / 2 - 64,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 8),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 5.2,
                                            height: 5.2,
                                            decoration: ShapeDecoration(
                                              color: theme.colorScheme.onSurface
                                                  .withValues(
                                                alpha: 0.7,
                                              ),
                                              shape: const OvalBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.adhd,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(
                                                  alpha: 0.7,
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 5.2,
                                            height: 5.2,
                                            decoration: ShapeDecoration(
                                              color: theme.colorScheme.onSurface
                                                  .withValues(
                                                alpha: 0.7,
                                              ),
                                              shape: const OvalBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.struggleToStart,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(
                                                  alpha: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 5.2,
                                            height: 5.2,
                                            decoration: ShapeDecoration(
                                              color: theme.colorScheme.onSurface
                                                  .withValues(
                                                alpha: 0.7,
                                              ),
                                              shape: const OvalBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.noFocus,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(
                                                  alpha: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 5.2,
                                            height: 5.2,
                                            decoration: ShapeDecoration(
                                              color: theme.colorScheme.onSurface
                                                  .withValues(
                                                alpha: 0.7,
                                              ),
                                              shape: const OvalBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.lackOfSupport,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(
                                                  alpha: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 5.2,
                                            height: 5.2,
                                            decoration: ShapeDecoration(
                                              color: theme.colorScheme.onSurface
                                                  .withValues(
                                                alpha: 0.7,
                                              ),
                                              shape: const OvalBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.poorResults,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(
                                                  alpha: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                      left: 155 / (393 - 48) * (mediaQuery.size.width - 48),
                      top: 0,
                      child: Container(
                        width: 190 / (393 - 48) * (mediaQuery.size.width - 48),
                        height: 539,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: primaryGradient,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const <BoxShadow>[
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 10,
                              offset: Offset(-11, 13),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 3.7861328125,
                              left: 0 / 393 * mediaQuery.size.width,
                              child: SizedBox(
                                height: 87.04,
                                child: assets.vector4.svg(
                                  width: 190 /
                                      (393 - 48) *
                                      (mediaQuery.size.width - 48),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 32,
                              left: 114 / 393 * mediaQuery.size.width,
                              child: assets.star34.svg(),
                            ),
                            Positioned(
                              top: 72,
                              left: 23 / 393 * mediaQuery.size.width,
                              child: assets.star34.svg(),
                            ),
                            Positioned(
                              top: 41,
                              left: 69 / 393 * mediaQuery.size.width,
                              child: assets.star34.svg(),
                            ),
                            Positioned(
                              top: 10.4814453125,
                              left: 50.990234375 / 393 * mediaQuery.size.width,
                              child: assets.star32.svg(),
                            ),
                            Positioned(
                              left: 101.98 / 393 * mediaQuery.size.width,
                              top: 58.90,
                              child: Container(
                                width: 21.63,
                                height: 21,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.secondary,
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.01,
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: theme.colorScheme.secondary,
                                      blurRadius: 4.71,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 182.33 / 393 * mediaQuery.size.width,
                              top: 44.99,
                              child: Container(
                                width: 18.04,
                                height: 17.51,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.secondary,
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.01,
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: theme.colorScheme.secondary,
                                      blurRadius: 3.93,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 84.47 / 393 * mediaQuery.size.width,
                              top: 58.90,
                              child: Container(
                                width: 2.06,
                                height: 2.06,
                                decoration: const ShapeDecoration(
                                  gradient: secondaryGradient,
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 121.55 / 393 * mediaQuery.size.width,
                              top: 9.97,
                              child: Container(
                                width: 2.06,
                                height: 2.06,
                                decoration: const ShapeDecoration(
                                  gradient: secondaryGradient,
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 80.86 / 393 * mediaQuery.size.width,
                              top: -1.88,
                              child: Container(
                                width: 18.04,
                                height: 17.51,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.secondary,
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.01,
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: theme.colorScheme.secondary,
                                      blurRadius: 3.93,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 31.42 / 393 * mediaQuery.size.width,
                              top: 33.14,
                              child: Container(
                                width: 14.94,
                                height: 14.50,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.secondary,
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.01,
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: theme.colorScheme.secondary,
                                      blurRadius: 3.25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 55 / 393 * mediaQuery.size.width,
                              top: 64,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.secondary,
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.01,
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: theme.colorScheme.secondary,
                                      blurRadius: 3.25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 147.82 / 393 * mediaQuery.size.width,
                              top: 11,
                              child: Container(
                                width: 11.85,
                                height: 11.33,
                                decoration: ShapeDecoration(
                                  color: theme.colorScheme.secondary,
                                  shape: const StarBorder(
                                    innerRadiusRatio: 0.01,
                                  ),
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                      color: theme.colorScheme.secondary,
                                      blurRadius: 3.93,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12.88 / 393 * mediaQuery.size.width,
                              top: 50.14,
                              child: Container(
                                width: 1.55,
                                height: 1.55,
                                decoration: const ShapeDecoration(
                                  gradient: secondaryGradient,
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 148 / 393 * mediaQuery.size.width,
                              top: 23,
                              child: SizedBox(
                                width: 40.22,
                                height: 39.66,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 49,
                                      left: 0,
                                      child: assets.star34.svg(),
                                    ),
                                    Positioned(
                                      top: 98,
                                      left: 0,
                                      child: assets.star34.svg(),
                                    ),
                                    Positioned(
                                      top: 136,
                                      left: 0,
                                      child: assets.star34.svg(),
                                    ),
                                    Positioned(
                                      top: 174,
                                      left: 0,
                                      child: assets.star34.svg(),
                                    ),
                                    Positioned(
                                      left: 3.63,
                                      top: 3.63,
                                      child: Container(
                                        width: 32.96,
                                        height: 32.40,
                                        decoration: ShapeDecoration(
                                          color: theme.colorScheme.secondary,
                                          shape: const OvalBorder(),
                                          shadows: const <BoxShadow>[
                                            BoxShadow(
                                              color: Color(0x3F000000),
                                              blurRadius: 2.06,
                                              offset: Offset(0, 2.06),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 40.22,
                                        height: 39.66,
                                        decoration: const ShapeDecoration(
                                          color: Color(0x7FFACD77),
                                          shape: OvalBorder(),
                                          shadows: <BoxShadow>[
                                            BoxShadow(
                                              color: Color(0x3F000000),
                                              blurRadius: 2.06,
                                              offset: Offset(0, 2.06),
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
                              left: 27 / 393 * mediaQuery.size.width,
                              top: 100,
                              child: SizedBox(
                                width: 117,
                                child: Text(
                                  i18n.withUs,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14 / 393 * mediaQuery.size.width,
                              top: 131,
                              child: SizedBox(
                                width: mediaQuery.size.width / 2 - 35,
                                height: 539,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 9),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          assets.star34.svg(
                                            width: 17,
                                            height: 22,
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.peaceOfMind,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          assets.star34.svg(
                                            width: 17,
                                            height: 22,
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.toDoPersonalizedPlan,
                                              style: theme.textTheme.bodyMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          assets.star34.svg(
                                            width: 17,
                                            height: 22,
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.aiCoach,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          assets.star34.svg(
                                            width: 17,
                                            height: 22,
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.focusOnYourself,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          assets.star34.svg(
                                            width: 17,
                                            height: 22,
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              i18n.reachingTheGoal,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
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
                      left: (mediaQuery.size.width - 48) / 2 - 213 / 2,
                      top: 342,
                      child: Container(
                        width: 213,
                        height: 198,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: assets.teamworkdiscussinganideainateam1
                                .provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 42)),
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
      ),
    );
  }
}
