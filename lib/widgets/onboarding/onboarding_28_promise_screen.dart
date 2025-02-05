import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'onboarding_28_promise_screen.g.dart';

@TypedGoRoute<Onboarding28PromiseRoute>(
  path: '/onboarding/28_promise',
)
class Onboarding28PromiseRoute extends GoRouteData {
  const Onboarding28PromiseRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding28PromiseScreen();

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
class Onboarding28PromiseScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding28PromiseScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA28PromiseEnUs i18n =
        I18N.of(context).onboarding.a28Promise;
    final $SourceAssetsOnboarding28PromiseGen assets =
        Assets.source.assets.onboarding.a28Promise;

    final ScrollController scrollController = useScrollController();
    final ValueNotifier<bool> isLoading = useState(false);
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
                  'onboarding_screen_27_clicked',
                  eventProperties: <String, Object?>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'fingerprint',
                    'answer': 'success',
                  },
                ),
              );
          final Routes<RouteData>? route =
              await ref.read(onboardingProvider.notifier).next();
          if (context.mounted) {
            await route?.pushReplacement(context);
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
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
        SliverToBoxAdapter(
          child: Text(
            i18n.areYouReady,
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium
                ?.copyWith(color: theme.colorScheme.secondary),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: i18n.commitmentIntro),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.userName(name: name),
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  TextSpan(text: i18n.commitmentStatement),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.boldCommitmentStatement,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  i18n.tapToCommit,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: 127.77,
                  height: 126,
                  child: HoldTimeoutDetector(
                    holdTimeout: const Duration(seconds: 4),
                    onTimerInitiated: () => isLoading.value = true,
                    onTap: () => isLoading.value = false,
                    onCancel: () => isLoading.value = false,
                    onTimeout: () async {
                      if (context.mounted) {
                        isLoading.value = false;
                      }
                      await next();
                    },
                    enableHapticFeedback: true,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 127.77,
                            height: 126,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 28,
                                  left: 32,
                                  child: assets.vector.svg(),
                                ),
                                Positioned(
                                  left: 11.54,
                                  top: 11.54,
                                  child: Container(
                                    width: 104.70,
                                    height: 102.93,
                                    decoration: ShapeDecoration(
                                      color: theme.colorScheme.secondary,
                                      shape: const OvalBorder(),
                                      shadows: const <BoxShadow>[
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 6.55,
                                          offset: Offset(0, 6.55),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 127.77,
                                    height: 126,
                                    decoration: const ShapeDecoration(
                                      color: Color(0x7FFACD77),
                                      shape: OvalBorder(),
                                      shadows: <BoxShadow>[
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 6.55,
                                          offset: Offset(0, 6.55),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 3.3,
                                    left: 1,
                                    top: 1.5,
                                    right: 1,
                                  ),
                                  child: Opacity(
                                    opacity: isLoading.value ? 1 : 0,
                                    child: RiveAnimation.asset(
                                      assets.fingerprintRiv,
                                      animations: const <String>[
                                        'loop',
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 4,
                                  top: 2,
                                  child: Opacity(
                                    opacity: isLoading.value ? 0 : 1,
                                    child: assets.fingerprintPng.image(),
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
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
