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

part 'onboarding_24_task_screen.g.dart';

@TypedGoRoute<Onboarding24TaskRoute>(
  path: '/onboarding/24_task',
)
class Onboarding24TaskRoute extends GoRouteData {
  const Onboarding24TaskRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding24TaskScreen();

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
class Onboarding24TaskScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding24TaskScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA24TaskEnUs i18n = I18N.of(context).onboarding.a24Task;
    final $SourceAssetsOnboarding24TaskGen assets =
        Assets.source.assets.onboarding.a24Task;

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
                  'onboarding_screen_23_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'baby_step',
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
          const SliverToBoxAdapter(child: SizedBox(height: 64)),
          SliverToBoxAdapter(
            child: Container(
              width: 393,
              height: 282.91,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 16,
                    left: 0 / 393 * mediaQuery.size.width,
                    child: SizedBox(
                      height: 229.77,
                      child: assets.vector1.svg(
                        width: mediaQuery.size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 79,
                    left: 164 / 393 * mediaQuery.size.width,
                    child: assets.star34.svg(),
                  ),
                  Positioned(
                    top: 108,
                    left: 71 / 393 * mediaQuery.size.width,
                    child: assets.star35.svg(),
                  ),
                  Positioned(
                    top: 210,
                    left: 208,
                    child: assets.star41.svg(),
                  ),
                  Positioned(
                    top: 197,
                    left: 325 / 393 * mediaQuery.size.width,
                    child: assets.star32.svg(),
                  ),
                  Positioned(
                    left: 86 / 393 * mediaQuery.size.width,
                    top: 151,
                    child: Container(
                      width: 71,
                      height: 68.91,
                      decoration: const ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Color(0xFFF2CF41),
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10 / 393 * mediaQuery.size.width,
                    top: 58,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: const ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Color(0xFFF2CF41),
                            blurRadius: 7.62,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 267 / 393 * mediaQuery.size.width,
                    top: 145,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 25 / 393 * mediaQuery.size.width,
                    top: 194,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 118 / 393 * mediaQuery.size.width,
                    top: 52,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -113.58 / 2,
                    top: 16,
                    child: SizedBox(
                      width: 113.58,
                      height: 112,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10.25,
                            top: 10.25,
                            child: Container(
                              width: 93.07,
                              height: 91.49,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF1C165),
                                shape: OvalBorder(),
                                shadows: <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5.87,
                                    offset: Offset(0, 5.87),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 113.58,
                              height: 112,
                              decoration: const ShapeDecoration(
                                color: Color(0x7FFACD77),
                                shape: OvalBorder(),
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
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                width: 348,
                height: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: i18n.yourFirst,
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.babyStep,
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      i18n.createWishlist,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 76)),
          SliverToBoxAdapter(
            child: SizedBox(
              width: 392.11,
              height: 117,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 7.8212890625,
                    left: 0,
                    child: SizedBox(
                      height: 109.18,
                      child: assets.vector4.svg(
                        width: mediaQuery.size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 279.55 / 393 * mediaQuery.size.width,
                    top: 33.04,
                    child: Container(
                      width: 26,
                      height: 25,
                      decoration: const ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Color(0xFFF2CF41),
                            blurRadius: 15.45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 116.11 / 393 * mediaQuery.size.width,
                    top: 42,
                    child: Container(
                      width: 35.03,
                      height: 34,
                      decoration: const ShapeDecoration(
                        gradient: secondaryGradient,
                        shape: StarBorder(
                          innerRadiusRatio: 0.01,
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Color(0xFFF2CF41),
                            blurRadius: 7.62,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 184.11 / 393 * mediaQuery.size.width,
                    top: 64,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 365.55 / 393 * mediaQuery.size.width,
                    top: 27.04,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 74.55 / 393 * mediaQuery.size.width,
                    top: 45.04,
                    child: Container(
                      width: 7,
                      height: 6,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
