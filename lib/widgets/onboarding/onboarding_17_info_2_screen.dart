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

part 'onboarding_17_info_2_screen.g.dart';

@TypedGoRoute<Onboarding17Info2Route>(
  path: '/onboarding/17_info_2',
)
class Onboarding17Info2Route extends GoRouteData {
  const Onboarding17Info2Route();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding17Info2Screen();

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
class Onboarding17Info2Screen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding17Info2Screen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA17Info2EnUs i18n =
        I18N.of(context).onboarding.a17Info2;
    final $SourceAssetsOnboarding17Info2Gen assets =
        Assets.source.assets.onboarding.a17Info2;

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
                  'onboarding_screen_16_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'mental_results',
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
        const SliverToBoxAdapter(child: SizedBox(height: 64)),
        SliverToBoxAdapter(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 250,
              maxHeight: 350,
            ),
            height: 350 / 852 * mediaQuery.size.height,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: assets.medicalmonitoringofhumanhealth1.provider(),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 344,
            padding: const EdgeInsets.symmetric(
              vertical: 48,
              horizontal: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: i18n.username(name: name),
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(text: i18n.thanksForSharing),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  height: 128,
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: i18n.your),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.mentalHealthState,
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: i18n.isGenerallyFavourable),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.canBeBetter,
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.withSomeSpecificInstruments,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 82)),
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
