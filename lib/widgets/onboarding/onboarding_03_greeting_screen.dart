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

part 'onboarding_03_greeting_screen.g.dart';

@TypedGoRoute<Onboarding03GreetingRoute>(
  path: '/onboarding/03_greeting',
)
class Onboarding03GreetingRoute extends GoRouteData {
  const Onboarding03GreetingRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding03GreetingScreen();

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
class Onboarding03GreetingScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding03GreetingScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA03GreetingEnUs i18n =
        I18N.of(context).onboarding.a03Greeting;
    final $SourceAssetsOnboarding03GreetingGen assets =
        Assets.source.assets.onboarding.a03Greeting;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);
    final String name = ref.read(nameProvider);

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
                  'onboarding_screen_2_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'nice2meet',
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
        slivers: <Widget>[
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
          SliverToBoxAdapter(
            child: Container(
              height: 350 / 852 * mediaQuery.size.height,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              constraints: const BoxConstraints(minHeight: 250, maxHeight: 350),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      assets.womancelebratingsuccessonsocialmedia1.provider(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: i18n.greeting,
                          style: theme.textTheme.headlineLarge,
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.name(name: name),
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        TextSpan(
                          text: i18n.exclamation,
                          style: theme.textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 84),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 52,
                        height: 52,
                        padding: const EdgeInsets.all(2),
                        child: assets.vector.svg(),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          i18n.goalStart,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 84),
                  SizedBox(
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          i18n.introduction,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
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
                      ],
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
