import 'dart:ui';

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

part 'onboarding_07_motivation_q1_screen.g.dart';

@TypedGoRoute<Onboarding07MotivationQ1Route>(
  path: '/onboarding/07_motivation_q1',
)
class Onboarding07MotivationQ1Route extends GoRouteData {
  const Onboarding07MotivationQ1Route();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding07MotivationQ1Screen();

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
class Onboarding07MotivationQ1Screen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding07MotivationQ1Screen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA07MotivationQ1EnUs i18n =
        I18N.of(context).onboarding.a07MotivationQ1;
    final $SourceAssetsOnboarding07MotivationQ1Gen assets =
        Assets.source.assets.onboarding.a07MotivationQ1;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    });

    Future<void> next({required final bool result}) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_6_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'motivation1',
                    'answer': result ? 'yes' : 'no',
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setMotivationQ1Result(result: result);
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
        const SliverToBoxAdapter(child: SizedBox(height: 70)),
        SliverToBoxAdapter(
          child: Container(
            height: 462,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
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
                  top: 326.82159423828125,
                  left: 0.8931818604469299 / 393 * mediaQuery.size.width,
                  child: SizedBox(
                    height: 109.18,
                    child: assets.vector4.svg(
                      width: mediaQuery.size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 9,
                  left: 237 / 393 * mediaQuery.size.width,
                  child: assets.star34.svg(),
                ),
                Positioned(
                  top: 26,
                  left: 74 / 393 * mediaQuery.size.width,
                  child: assets.star35.svg(),
                ),
                Positioned(
                  top: 319,
                  left: 280 / 393 * mediaQuery.size.width,
                  child: assets.star36.svg(),
                ),
                Positioned(
                  top: 232,
                  left: 328 / 393 * mediaQuery.size.width,
                  child: assets.star32.svg(),
                ),
                Positioned(
                  left: 133 / 393 * mediaQuery.size.width,
                  top: 36,
                  child: Container(
                    width: 71,
                    height: 68.91,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 15.45,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 4 / 393 * mediaQuery.size.width,
                  top: 198,
                  child: Container(
                    width: 71,
                    height: 68.91,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 15.45,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 224 / 393 * mediaQuery.size.width,
                  top: 363,
                  child: Container(
                    width: 71,
                    height: 68.91,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 15.45,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 116 / 393 * mediaQuery.size.width,
                  top: 360,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 7.62,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 268 / 393 * mediaQuery.size.width,
                  top: 83,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 7.62,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20 / 393 * mediaQuery.size.width,
                  top: 63,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 7.62,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 184 / 393 * mediaQuery.size.width,
                  top: 382,
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
                  left: 14 / 393 * mediaQuery.size.width,
                  top: 357,
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
                  left: 187 / 393 * mediaQuery.size.width,
                  top: 129,
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
                  left: 147 / 393 * mediaQuery.size.width,
                  top: -16,
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
                  left: 366 / 393 * mediaQuery.size.width,
                  top: 406,
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
                  left: mediaQuery.size.width / 2 - 365.16 / 2 + 4,
                  top: 55.85 + 16,
                  child: SizedBox(
                    width: 365.16,
                    height: 350.61,
                    child: Opacity(
                      opacity: 0.25,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 16,
                          sigmaY: 16,
                        ),
                        child: assets.cloudstorageandmanusingthecloud1
                            .image(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: mediaQuery.size.width / 2 - 365.16 / 2,
                  top: 55.85,
                  child: Container(
                    width: 365.16,
                    height: 350.61,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            assets.cloudstorageandmanusingthecloud1.provider(),
                        fit: BoxFit.contain,
                      ),
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
            height: 320,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: i18n.feelingIntro),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.feelingLost,
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      TextSpan(
                        text: i18n.workingOnDreamsIntro,
                        style: theme.textTheme.titleMedium,
                      ),
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: i18n.workingOnDreams,
                        style: theme.textTheme.titleMedium,
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.dreams,
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 64),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 62,
                        height: 62,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: theme.colorScheme.onSurface,
                          shape: const OvalBorder(),
                          shadows: const <BoxShadow>[buttonShadow],
                        ),
                        child: TextButton(
                          onPressed: () async => next(result: false),
                          style: TextButton.styleFrom(
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                            padding: const EdgeInsets.only(
                              top: 22,
                              left: 21,
                              right: 22,
                              bottom: 21,
                            ),
                          ),
                          child: assets.cross.svg(height: 19, width: 19),
                        ),
                      ),
                      const SizedBox(width: 116),
                      Container(
                        width: 62,
                        height: 62,
                        clipBehavior: Clip.antiAlias,
                        decoration: const ShapeDecoration(
                          gradient: primaryGradient,
                          shape: OvalBorder(),
                          shadows: <BoxShadow>[buttonShadow],
                        ),
                        child: TextButton(
                          onPressed: () async => next(result: true),
                          style: TextButton.styleFrom(
                            overlayColor: theme.colorScheme.onSurface,
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                          ),
                          child: assets.heart.svg(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
