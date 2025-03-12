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

part 'onboarding_10_motivation_level_screen.g.dart';

@TypedGoRoute<Onboarding10MotivationLevelRoute>(
  path: '/onboarding/10_motivation_level',
)
class Onboarding10MotivationLevelRoute extends GoRouteData {
  const Onboarding10MotivationLevelRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding10MotivationLevelScreen();

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
class Onboarding10MotivationLevelScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding10MotivationLevelScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA10MotivationLevelEnUs i18n =
        I18N.of(context).onboarding.a10MotivationLevel;
    final $SourceAssetsOnboarding10MotivationLevelGen assets =
        Assets.source.assets.onboarding.a10MotivationLevel;
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
          await ref
              .read(analyticsProvider.notifier)
              .track(
                BaseEvent(
                  'onboarding_screen_9_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'motiv_results',
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

    final AsyncValue<double?> $motivationLevel = ref.watch(
      onboardingProvider.select(
        (final AsyncValue<OnboardingState> onboarding) => onboarding.whenData(
          (final OnboardingState onboarding) => onboarding.motivationLevel,
        ),
      ),
    );
    final double? prevMotivationLevel = usePrevious<double?>(
      $motivationLevel.valueOrNull,
    );
    final double motivationLevel =
        $motivationLevel.valueOrNull ?? prevMotivationLevel ?? 0;
    return Container(
      padding: mediaQuery.viewPadding + mediaQuery.viewInsets,
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        slivers: <Widget>[
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: Container(
              height: 350 / 852 * mediaQuery.size.height,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              constraints: const BoxConstraints(
                minHeight: 250,
                maxHeight: 350,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      assets.thehandholdingthesalesignwithitsfingers1
                          .provider(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Text(
                    i18n.hereYouAre,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: i18n.motivationStatus.start),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.motivationStatus.level,
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.motivationStatus.completion(
                            percent: (motivationLevel * 100).toInt(),
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.motivationStatus.state,
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    i18n.improvementMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
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
