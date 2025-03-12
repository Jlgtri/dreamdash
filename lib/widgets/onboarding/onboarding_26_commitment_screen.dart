import 'dart:async';

import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/onboarding.dart';
import '../utils.dart';
import 'utils/onboarding_star_header.dart';

part 'onboarding_26_commitment_screen.g.dart';

@TypedGoRoute<Onboarding26CommitmentRoute>(path: '/onboarding/26_commitment')
class Onboarding26CommitmentRoute extends GoRouteData {
  const Onboarding26CommitmentRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding26CommitmentScreen();

  @override
  CustomTransitionPage<void> buildPage(
    final BuildContext context,
    final GoRouterState state,
  ) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: build(context, state),
    transitionDuration: const Duration(milliseconds: 600),
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
class Onboarding26CommitmentScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding26CommitmentScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA26CommitmentEnUs i18n =
        I18N.of(context).onboarding.a26Commitment;
    final $SourceAssetsOnboarding26CommitmentGen assets =
        Assets.source.assets.onboarding.a26Commitment;
    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    });

    Future<void> next(final DailyGoal dailyGoal) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref
              .read(analyticsProvider.notifier)
              .track(
                BaseEvent(
                  'onboarding_screen_25_clicked',
                  eventProperties: <String, Object?>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'daily_goal',
                    'answer': dailyGoal.name,
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setDailyGoal(dailyGoal);
          if (context.mounted) {
            ref.read(onboardingProvider).requireValue.route?.go(context);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    final Stopwatch stopwatch = ref.watch(
      onboardingProvider.notifier.select(
        (final Onboarding onboarding) => onboarding.stopwatch,
      ),
    );
    final ValueNotifier<Duration> currentTime = useState(stopwatch.elapsed);
    final Timer timer = useMemoized(
      () => Timer.periodic(
        const Duration(seconds: 1),
        (final _) => currentTime.value = stopwatch.elapsed,
      ),
      <Object?>[stopwatch],
    );
    useEffect(() => timer.cancel, <Object?>[timer]);
    final Timer? previousTimer = usePrevious(timer);
    useMemoized(() => previousTimer?.cancel(), <Object?>[
      previousTimer != null && previousTimer != timer,
    ]);

    return Container(
      padding: (mediaQuery.viewPadding + mediaQuery.viewInsets).copyWith(
        top: 0,
      ),
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        slivers: <Widget>[
          const SliverToBoxAdapter(child: OnboardingStarHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
          SliverToBoxAdapter(
            child: Container(
              height: 167,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    i18n.watchProgress,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${currentTime.value.inMinutes % 60}:'
                    '${(currentTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    i18n.movingTowardsDreams,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    i18n.keepUp,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: i18n.setYour),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.dailyGoal,
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: () async => next(DailyGoal.min5),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 13,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              i18n.dailyGoals.a5Min,
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 78,
                              child: Text(
                                i18n.dailyGoals.a5MinLabel,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 450,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: () async => next(DailyGoal.min10),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 13,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              i18n.dailyGoals.a10Min,
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 78,
                              child: Text(
                                i18n.dailyGoals.a10MinLabel,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 450,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: () async => next(DailyGoal.min15),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 13,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              i18n.dailyGoals.a15Min,
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 80,
                              child: Text(
                                i18n.dailyGoals.a15MinLabel,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 450,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: () async => next(DailyGoal.min20),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 13,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              i18n.dailyGoals.a20Min,
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 78,
                              child: Text(
                                i18n.dailyGoals.a20MinLabel,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
