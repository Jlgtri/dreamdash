import 'dart:async';
import 'dart:math';

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

part 'onboarding_30_paywall_screen.g.dart';

@TypedGoRoute<Onboarding30PaywallRoute>(
  path: '/onboarding/30_paywall',
)
class Onboarding30PaywallRoute extends GoRouteData {
  const Onboarding30PaywallRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding30PaywallScreen();

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
class Onboarding30PaywallScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding30PaywallScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA30PaywallEnUs i18n =
        I18N.of(context).onboarding.a30Paywall;
    final $SourceAssetsOnboarding30PaywallGen assets =
        Assets.source.assets.onboarding.a30Paywall;
    final ObjectRef<bool> isLoading = useRef(false);
    final ScrollController scrollController = useScrollController();
    final ValueNotifier<PaywallPeriod> selectedPeriod =
        useState(PaywallPeriod.annually);
    final String name = ref.read(nameProvider);

    final DateTime now = DateTime.now();
    final String month = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][now.month - 1];
    final String currentDate = 'the ${now.day}th of $month ${now.year}';

    Future<void> next() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'paywall_screen_clicked',
                  eventProperties: <String, Object?>{
                    'placement': 'onboarding',
                    'ob_type': 'quiz_1',
                    'screen_type': 'letter',
                    'answer': 'continue',
                  },
                ),
              );
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  selectedPeriod.value == PaywallPeriod.weekly
                      ? 'onboarding_boarding_pass_free'
                      : 'onboarding_boarding_pass',
                  eventProperties: <String, Object?>{
                    'ob_type': 'quiz_1',
                  },
                ),
              );
          final OnboardingState onboarding =
              await ref.refresh(onboardingProvider.future);
          if (context.mounted) {
            await onboarding.route?.pushReplacement(context);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    unawaited(
      useMemoized(
        () async => ref.read(analyticsProvider.notifier).track(
              BaseEvent(
                'paywall_screen_shown',
                eventProperties: <String, Object?>{
                  'placement': 'onboarding',
                  'ob_type': 'quiz_1',
                  'screen_type': 'letter',
                },
              ),
            ),
      ),
    );

    // useMemoized(() {
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (final _) async => scrollController.scrollToBottom(),
    //   );
    // });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 46,
        leadingWidth: 66,
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: IconButton(
            onPressed: next,
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(
                horizontal: -4,
                vertical: -4,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(10),
              child: assets.cross.svg(
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(gradient: primaryGradient),
        child: CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,
          clipBehavior: Clip.antiAlias,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 46,
                color: theme.colorScheme.primaryContainer,
              ),
            ),
            const SliverToBoxAdapter(
              child: OnboardingStarHeader(height: 80),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      i18n.title(name: name),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(text: i18n.today.todayIs),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.today.date(date: currentDate),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: i18n.today.bestLife),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      i18n.decisionMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      i18n.healthMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      i18n.supportMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(text: i18n.seeYouSoon),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text: i18n.farewell(name: name),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 325 - 76,
                      width: min(mediaQuery.size.width - 24, 450),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 85 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 0,
                            child: SizedBox(
                              width: 78,
                              child: Text(
                                i18n.buttons.fixed,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 59.27 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 43,
                            child: Container(
                              width: 113.94,
                              height: 22.73,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 14.54,
                                    top: 3,
                                    child: SizedBox(
                                      width: 84.42,
                                      child: Text(
                                        i18n.buttons.iCantDoIt,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 35.63 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 84.72,
                            child: Container(
                              width: 113.94,
                              height: 22.73,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 14.27,
                                    top: 3.28,
                                    child: SizedBox(
                                      width: 84.42,
                                      child: Text(
                                        i18n.buttons.iGiveUp,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 126.44,
                            child: Container(
                              width: 113.94,
                              height: 22.73,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 15,
                                    top: 3.56,
                                    child: SizedBox(
                                      width: 84.42,
                                      child: Text(
                                        i18n.buttons.tooHard,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 35.63 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 168.15,
                            child: Container(
                              width: 113.94,
                              height: 22.73,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 3.27,
                                    top: 3.85,
                                    child: SizedBox(
                                      width: 107.15,
                                      child: Text(
                                        i18n.buttons.dontKnowHow,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 60.11 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 209.11,
                            child: Container(
                              width: 113.94,
                              height: 38.96,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 10.73,
                                    top: 3.89,
                                    child: SizedBox(
                                      width: 92.54,
                                      child: Text(
                                        i18n.buttons.notGoodAtThis,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 187 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 2,
                            child: SizedBox(
                              width: 94,
                              child: Text(
                                i18n.buttons.growth,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 210.51 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 43,
                            child: Container(
                              width: 123.23,
                              height: 22.73,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                                shadows: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(5, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 5.98,
                                    top: 3,
                                    child: SizedBox(
                                      width: 113.65,
                                      child: Text(
                                        i18n.buttons.keepTrying,
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: theme
                                              .colorScheme.primaryContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 234.14 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 175.62,
                            child: Container(
                              width: 123.23,
                              height: 22.73,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.primaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                                shadows: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(5, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: -1.75,
                                    top: 3.38,
                                    child: SizedBox(
                                      width: 130.69,
                                      child: Text(
                                        i18n.buttons.canLearn,
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 210.51 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 208.34,
                            child: Container(
                              width: 123.23,
                              height: 38.96,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                                shadows: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(5, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 27.98,
                                    top: 3.66,
                                    child: SizedBox(
                                      width: 70.62,
                                      child: Text(
                                        i18n.buttons.howGetBetter,
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: theme
                                              .colorScheme.primaryContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 234.14 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 76,
                            child: Container(
                              width: 123.23,
                              height: 38.96,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.primaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                                shadows: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(5, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 7.25,
                                    top: 3.28,
                                    child: SizedBox(
                                      width: 112.02,
                                      child: Text(
                                        i18n.buttons.tryDifferentWay,
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 257.77 /
                                (393 - 24) *
                                (min(mediaQuery.size.width - 24, 450)),
                            top: 125.67,
                            child: Container(
                              width: 123.23,
                              height: 38.96,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.18),
                                ),
                                shadows: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(5, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 10.52,
                                    top: 3.33,
                                    child: SizedBox(
                                      width: 104.72,
                                      child: Text(
                                        i18n.buttons.practiceGetEasier,
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: theme
                                              .colorScheme.primaryContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 134 /
                                (393 - 24) *
                                min(mediaQuery.size.width - 24, 450),
                            top: 70,
                            child: Container(
                              width: 119,
                              height: 119,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: assets.womanwritingcodeonlaptop2
                                      .provider(),
                                  fit: BoxFit.contain,
                                ),
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
            const SliverToBoxAdapter(child: SizedBox(height: 36)),
            SliverToBoxAdapter(
              child: SizedBox(
                width: 272,
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: i18n.changeYour),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.mindset,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: Container(
                height: 416,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: 450,
                constraints: const BoxConstraints(maxWidth: 450),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 136,
                      width: 450,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 0,
                            top: 20,
                            child: Container(
                              width: mediaQuery.size.width - 48,
                              height: 116,
                              constraints: const BoxConstraints(maxWidth: 450),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: theme.colorScheme.primaryContainer,
                                shape: RoundedRectangleBorder(
                                  side: selectedPeriod.value ==
                                          PaywallPeriod.annually
                                      ? const BorderSide(
                                          width: 3,
                                          color: Color(0xFFFBD080),
                                        )
                                      : BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => selectedPeriod.value =
                                    PaywallPeriod.annually,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  overlayColor: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                  visualDensity: const VisualDensity(
                                    horizontal: -4,
                                    vertical: -4,
                                  ),
                                  shape: const RoundedRectangleBorder(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ) -
                                      EdgeInsets.all(
                                        selectedPeriod.value ==
                                                PaywallPeriod.annually
                                            ? 3
                                            : 0,
                                      ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 205,
                                        height: 28,
                                        child: Text(
                                          i18n.pricing.annually.title(days: 3),
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: 294,
                                        child: Text(
                                          i18n.pricing.annually.weeklyPrice(
                                            price: r'$0,96',
                                          ),
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        width: 294,
                                        child: Text.rich(
                                          TextSpan(
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    i18n.pricing.annually.price(
                                                  price: r'$49,99',
                                                ),
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: theme
                                                      .colorScheme.secondary,
                                                ),
                                              ),
                                              const TextSpan(text: ' '),
                                              TextSpan(
                                                text: i18n
                                                    .pricing.annually.period,
                                                style:
                                                    theme.textTheme.bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 0,
                            child: Container(
                              width: 100,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                gradient: secondaryGradient,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 3,
                                    color: Color(0xFFFBD080),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const <BoxShadow>[buttonShadow],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: SizedBox(
                                  width: 88,
                                  height: 28,
                                  child: Text(
                                    i18n.pricing.saveOffer(percent: 88),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: mediaQuery.size.width - 48,
                      height: 116,
                      constraints: const BoxConstraints(maxWidth: 450),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          side: selectedPeriod.value == PaywallPeriod.monthly
                              ? const BorderSide(
                                  width: 3,
                                  color: Color(0xFFFBD080),
                                )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () =>
                            selectedPeriod.value = PaywallPeriod.monthly,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          overlayColor: theme.colorScheme.onSurface
                              .withValues(alpha: 0.3),
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ) -
                              EdgeInsets.all(
                                selectedPeriod.value == PaywallPeriod.monthly
                                    ? 3
                                    : 0,
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                width: 92,
                                height: 28,
                                child: Text(
                                  i18n.pricing.monthly.title,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 99,
                                child: Text(
                                  i18n.pricing.monthly.price(price: r'$5'),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 289,
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: i18n.pricing.monthly.price(
                                          price: r'$19,99',
                                        ),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: i18n.pricing.monthly.period,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: mediaQuery.size.width - 48,
                      height: 116,
                      constraints: const BoxConstraints(maxWidth: 450),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          side: selectedPeriod.value == PaywallPeriod.weekly
                              ? const BorderSide(
                                  width: 3,
                                  color: Color(0xFFFBD080),
                                )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () =>
                            selectedPeriod.value = PaywallPeriod.weekly,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          overlayColor: theme.colorScheme.onSurface
                              .withValues(alpha: 0.3),
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ) -
                              EdgeInsets.all(
                                selectedPeriod.value == PaywallPeriod.weekly
                                    ? 3
                                    : 0,
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                width: 92,
                                height: 28,
                                child: Text(
                                  i18n.pricing.weekly.title,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 99,
                                child: Text(
                                  i18n.pricing.weekly.price(price: r'$7,99'),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 289,
                                child: Text(
                                  i18n.pricing.weekly.period,
                                  style: theme.textTheme.bodyMedium,
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
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Container(
                width: 450,
                height: 132,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 450,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF1C165),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        shadows: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 4,
                            offset: Offset(5, 4),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          selectedPeriod.value == PaywallPeriod.annually
                              ? i18n.footer.tryFree(days: 3)
                              : i18n.footer.buttonText,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      i18n.footer.hintText(store: 'the App Store'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 450,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                overlayColor: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  i18n.footer.termsOfUse,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelSmall,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                overlayColor: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  i18n.footer.privacyPolicy,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelSmall,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                overlayColor: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  i18n.footer.restore,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
