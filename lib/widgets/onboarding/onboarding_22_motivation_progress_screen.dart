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

part 'onboarding_22_motivation_progress_screen.g.dart';

@TypedGoRoute<Onboarding22MotivationProgressRoute>(
  path: '/onboarding/22_motivation_progress',
)
class Onboarding22MotivationProgressRoute extends GoRouteData {
  const Onboarding22MotivationProgressRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding22MotivationProgressScreen();

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
class Onboarding22MotivationProgressScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding22MotivationProgressScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA22MotivationProgressEnUs i18n =
        I18N.of(context).onboarding.a22MotivationProgress;
    final $SourceAssetsOnboarding22MotivationProgressGen assets =
        Assets.source.assets.onboarding.a22MotivationProgress;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    final String name = ref.read(nameProvider);
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
                  'onboarding_screen_21_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'progress',
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
                  TextSpan(
                    text: i18n.title.username(name: name),
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  TextSpan(text: i18n.title.separator),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.title.forTheNext),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.title.weeks(amount: 5),
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.title.weWill),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.title.hitYourGoal,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.title.keepYouMotivation),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 73)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: mediaQuery.size.width - 48,
                  height: 297,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        top: 25.50,
                        child: SizedBox(
                          height: 165.50,
                          width: mediaQuery.size.width - 48,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 61.47998046875,
                                left: 0,
                                child: SizedBox(
                                  height: 89.74,
                                  child: assets.line.svg(
                                    width: mediaQuery.size.width - 48,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    28.79 / 345 * (mediaQuery.size.width - 48),
                                top: 135,
                                child: Container(
                                  width: 7.94,
                                  height: 8,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: const OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    96.31 / 345 * (mediaQuery.size.width - 48),
                                top: 66,
                                child: Container(
                                  width: 7.94,
                                  height: 8,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: const OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    163.82 / 345 * (mediaQuery.size.width - 48),
                                top: 124,
                                child: Container(
                                  width: 7.94,
                                  height: 8,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: const OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    231.33 / 345 * (mediaQuery.size.width - 48),
                                top: 107,
                                child: Container(
                                  width: 7.94,
                                  height: 8,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: const OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    297.85 / 345 * (mediaQuery.size.width - 48),
                                top: 57,
                                child: Container(
                                  width: 7.94,
                                  height: 8,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: const OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    28.79 / 345 * (mediaQuery.size.width - 48) -
                                        (28.79 - 9),
                                top: 147.50,
                                child: Container(
                                  width: 87.37,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 7.20,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 15,
                                        top: 1,
                                        child: SizedBox(
                                          width: 58,
                                          child: Text(
                                            i18n.states.week1,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color:
                                                  theme.colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left:
                                    96.31 / 345 * (mediaQuery.size.width - 48) -
                                        (96.31 - 68.51),
                                top: 45,
                                child: Container(
                                  width: 63.54,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 7.20,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 18,
                                        top: 2,
                                        child: SizedBox(
                                          width: 29,
                                          height: 14,
                                          child: Text(
                                            i18n.states.week2,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 163.82 /
                                        345 *
                                        (mediaQuery.size.width - 48) -
                                    (163.82 - 124.10),
                                top: 138,
                                child: Container(
                                  width: 87.37,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 7.20,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 21,
                                        top: 1,
                                        child: SizedBox(
                                          width: 45,
                                          height: 16,
                                          child: Text(
                                            i18n.states.week3,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color:
                                                  theme.colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 231.33 /
                                        345 *
                                        (mediaQuery.size.width - 48) -
                                    (231.33 - 225.37),
                                top: 118,
                                child: Container(
                                  width: 87.37,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 7.20,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 19.30,
                                        top: 1,
                                        child: SizedBox(
                                          width: 49,
                                          child: Text(
                                            i18n.states.week4,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 297.85 /
                                        345 *
                                        (mediaQuery.size.width - 48) -
                                    (297.85 - 257.63),
                                top: 0,
                                child: Container(
                                  width: 87.37,
                                  height: 54,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 7.20,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 15,
                                        top: 3,
                                        child: SizedBox(
                                          width: 58,
                                          child: Text(
                                            i18n.states.week5,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color:
                                                  theme.colorScheme.secondary,
                                            ),
                                          ),
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
                        left: 0 / 345 * (mediaQuery.size.width - 48),
                        top: 223,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width:
                                  66 / 345 * (mediaQuery.size.width - 48) + 4,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    child: assets.vector.svg(
                                      fit: BoxFit.fill,
                                      width: 66 /
                                          345 *
                                          (mediaQuery.size.width - 48),
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.onSurface
                                            .withValues(alpha: 0.3),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    i18n.weeks.week1,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  66 / 345 * (mediaQuery.size.width - 48) + 4,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    child: assets.vector.svg(
                                      fit: BoxFit.fill,
                                      width: 66 /
                                          345 *
                                          (mediaQuery.size.width - 48),
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.secondary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    i18n.weeks.week2,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  66 / 345 * (mediaQuery.size.width - 48) + 4,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    child: assets.vector.svg(
                                      fit: BoxFit.fill,
                                      width: 66 /
                                          345 *
                                          (mediaQuery.size.width - 48),
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.onSurface
                                            .withValues(alpha: 0.3),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    i18n.weeks.week3,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  66 / 345 * (mediaQuery.size.width - 48) + 4,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    child: assets.vector.svg(
                                      fit: BoxFit.fill,
                                      width: 66 /
                                          345 *
                                          (mediaQuery.size.width - 48),
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.secondary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    i18n.weeks.week4,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  66 / 345 * (mediaQuery.size.width - 48) + 8,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    child: assets.vector.svg(
                                      fit: BoxFit.fill,
                                      width: 66 /
                                          345 *
                                          (mediaQuery.size.width - 48),
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.onSurface,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    i18n.weeks.week5,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 73)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: i18n.usage.use),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.usage.dreamdash,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.usage.createPlan),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.usage.askForMotivation,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: i18n.usage.fromCoach),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 73)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: mediaQuery.size.width - 48,
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
