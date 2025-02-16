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

part 'onboarding_11_progress_screen.g.dart';

@TypedGoRoute<Onboarding11ProgressRoute>(
  path: '/onboarding/11_progress',
)
class Onboarding11ProgressRoute extends GoRouteData {
  const Onboarding11ProgressRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding11ProgressScreen();

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
class Onboarding11ProgressScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding11ProgressScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA11ProgressEnUs i18n =
        I18N.of(context).onboarding.a11Progress;
    final $SourceAssetsOnboarding11ProgressGen assets =
        Assets.source.assets.onboarding.a11Progress;

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
                  'onboarding_screen_10_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'ready_65',
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

    return Container(
      padding: mediaQuery.viewPadding + mediaQuery.viewInsets,
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 250,
                maxHeight: 450,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 371 / 852 * mediaQuery.size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: assets.progress.provider(),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: i18n.greeting.thanks),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.greeting.name(name: name),
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
                        TextSpan(text: i18n.profileReady.message),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.profileReady.completion(percent: 65),
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 48),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: i18n.lastStep.prompt,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.lastStep.assessment,
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Text(
                    i18n.motivationMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
