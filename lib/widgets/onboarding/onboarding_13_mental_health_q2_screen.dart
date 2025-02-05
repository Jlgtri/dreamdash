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

part 'onboarding_13_mental_health_q2_screen.g.dart';

@TypedGoRoute<Onboarding13MentalHealthQ2Route>(
  path: '/onboarding/13_mental_health_q2',
)
class Onboarding13MentalHealthQ2Route extends GoRouteData {
  const Onboarding13MentalHealthQ2Route();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding13MentalHealthQ2Screen();

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
class Onboarding13MentalHealthQ2Screen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding13MentalHealthQ2Screen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA13MentalHealthQ2EnUs i18n =
        I18N.of(context).onboarding.a13MentalHealthQ2;
    final $SourceAssetsOnboarding13MentalHealthQ2Gen assets =
        Assets.source.assets.onboarding.a13MentalHealthQ2;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    });

    Future<void> next(final Frequency frequency) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_12_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'meantheal2',
                    'answer': frequency.name,
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setMentalHealthQ2Result(frequency);
          if (context.mounted) {
            ref.read(onboardingProvider).requireValue.route?.go(context);
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
        const SliverToBoxAdapter(child: OnboardingStarHeader()),
        const SliverToBoxAdapter(child: SizedBox(height: 71)),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 48,
            ),
            child: Column(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: i18n.doYou),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.feelOverwhelmed,
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(text: i18n.byComplexityOfGoals),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  height: 264,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 450,
                        height: 48,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async => next(Frequency.almostAlways),
                          style: TextButton.styleFrom(
                            overlayColor: theme.colorScheme.onSurface,
                          ),
                          child: Text(
                            i18n.almostAlways,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge,
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
                        ),
                        child: TextButton(
                          onPressed: () async => next(Frequency.often),
                          style: TextButton.styleFrom(
                            overlayColor: theme.colorScheme.onSurface,
                          ),
                          child: Text(
                            i18n.often,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge,
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
                        ),
                        child: TextButton(
                          onPressed: () async => next(Frequency.sometimes),
                          style: TextButton.styleFrom(
                            overlayColor: theme.colorScheme.onSurface,
                          ),
                          child: Text(
                            i18n.sometimes,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge,
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
                        ),
                        child: TextButton(
                          onPressed: () async => next(Frequency.never),
                          style: TextButton.styleFrom(
                            overlayColor: theme.colorScheme.onSurface,
                          ),
                          child: Text(
                            i18n.never,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge,
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
    );
  }
}
