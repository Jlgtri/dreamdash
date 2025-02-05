import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'onboarding_23_testimonials_screen.g.dart';

@TypedGoRoute<Onboarding23TestimonialsRoute>(
  path: '/onboarding/23_testimonials',
)
class Onboarding23TestimonialsRoute extends GoRouteData {
  const Onboarding23TestimonialsRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding23TestimonialsScreen();

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
class Onboarding23TestimonialsScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding23TestimonialsScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA23TestimonialsEnUs i18n =
        I18N.of(context).onboarding.a23Testimonials;
    final $SourceAssetsOnboarding23TestimonialsGen assets =
        Assets.source.assets.onboarding.a23Testimonials;

    final ObjectRef<int> carousel1Index = useRef(0);
    final ObjectRef<int> carousel2Index = useRef(0);
    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    // useMemoized(() {
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (final _) async => scrollController.scrollToBottom(),
    //   );
    // });

    Future<void> next() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_22_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'reviews',
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

    String feedbackName(final int index) {
      switch (index) {
        case 0:
          return i18n.feedback.liya.name;
        case 1:
          return i18n.feedback.nolan.name;
        case 2:
          return i18n.feedback.bishop.name;
        case 3:
          return i18n.feedback.rebecca.name;
        case 4:
          return i18n.feedback.annie.name;
        case 5:
          return i18n.feedback.robbert.name;
        default:
          return '';
      }
    }

    String feedbackBody(final int index) {
      switch (index) {
        case 0:
          return i18n.feedback.liya.body;
        case 1:
          return i18n.feedback.nolan.body;
        case 2:
          return i18n.feedback.bishop.body;
        case 3:
          return i18n.feedback.rebecca.body;
        case 4:
          return i18n.feedback.annie.body;
        case 5:
          return i18n.feedback.robbert.body;
        default:
          return '';
      }
    }

    String feedbackPrefix(final int index) {
      switch (index) {
        case 0:
          return i18n.feedback.liya.prefix;
        case 1:
          return i18n.feedback.nolan.prefix;
        case 2:
          return i18n.feedback.bishop.prefix;
        case 3:
          return i18n.feedback.rebecca.prefix;
        case 4:
          return i18n.feedback.annie.prefix;
        case 5:
          return i18n.feedback.robbert.prefix;
        default:
          return '';
      }
    }

    String feedbackSuffix(final int index) {
      switch (index) {
        case 0:
          return i18n.feedback.liya.suffix;
        case 1:
          return i18n.feedback.nolan.suffix;
        case 2:
          return i18n.feedback.bishop.suffix;
        case 3:
          return i18n.feedback.rebecca.suffix;
        case 4:
          return i18n.feedback.annie.suffix;
        case 5:
          return i18n.feedback.robbert.suffix;
        default:
          return '';
      }
    }

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: i18n.title.whatOtherPeopleSay),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.title.aboutUs,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        SliverToBoxAdapter(
          child: Container(
            width: mediaQuery.size.width,
            height: 188,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 19,
                  left: 0 / 393 * mediaQuery.size.width,
                  child: SizedBox(
                    height: 169,
                    child: assets.vector4.svg(
                      width: mediaQuery.size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 101 / 393 * mediaQuery.size.width,
                  top: 71,
                  child: SizedBox(
                    width: 203,
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: i18n.subtitle.over(amount: 100),
                            style: theme.textTheme.titleLarge,
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: i18n.subtitle.livesChanged,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  right: -78.08 / 2,
                  top: 0,
                  child: SizedBox(
                    width: 78.08,
                    height: 77,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 118,
                          left: 54,
                          child: assets.star34.svg(),
                        ),
                        Positioned(
                          top: 146,
                          left: 126,
                          child: assets.star32.svg(),
                        ),
                        Positioned(
                          left: 7.05,
                          top: 7.05,
                          child: Container(
                            width: 63.99,
                            height: 62.90,
                            decoration: ShapeDecoration(
                              color: theme.colorScheme.secondary,
                              shape: const OvalBorder(),
                              shadows: const <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 78.08,
                            height: 77,
                            decoration: const ShapeDecoration(
                              color: Color(0x7FFACD77),
                              shape: OvalBorder(),
                              shadows: <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 301 / 393 * mediaQuery.size.width,
                  top: 70,
                  child: Container(
                    width: 42,
                    height: 40.76,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 9.14,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 359 / 393 * mediaQuery.size.width,
                  top: 112,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
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
                  left: 106 / 393 * mediaQuery.size.width,
                  top: 74,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 334 / 393 * mediaQuery.size.width,
                  top: 48,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 53 / 393 * mediaQuery.size.width,
                  top: 146,
                  child: Container(
                    width: 35.03,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
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
                  left: 61 / 393 * mediaQuery.size.width,
                  top: 76,
                  child: Container(
                    width: 29,
                    height: 28.15,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
                      shape: const StarBorder(
                        innerRadiusRatio: 0.01,
                      ),
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.secondary,
                          blurRadius: 6.31,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 287 / 393 * mediaQuery.size.width,
                  top: 33,
                  child: Container(
                    width: 23,
                    height: 22,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.secondary,
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
                  left: 25 / 393 * mediaQuery.size.width,
                  top: 109,
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: const ShapeDecoration(
                      gradient: secondaryGradient,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 106 / 393 * mediaQuery.size.width,
                  top: 33,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      boxShadow: <BoxShadow>[buttonShadow],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const ShapeDecoration(
                            gradient: secondaryGradient,
                            shape: StarBorder(
                              innerRadiusRatio: 0.38,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const ShapeDecoration(
                            gradient: secondaryGradient,
                            shape: StarBorder(
                              innerRadiusRatio: 0.38,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const ShapeDecoration(
                            gradient: secondaryGradient,
                            shape: StarBorder(
                              innerRadiusRatio: 0.38,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const ShapeDecoration(
                            gradient: secondaryGradient,
                            shape: StarBorder(
                              innerRadiusRatio: 0.38,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const ShapeDecoration(
                            gradient: secondaryGradient,
                            shape: StarBorder(
                              innerRadiusRatio: 0.38,
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
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        SliverToBoxAdapter(
          child: FlutterCarousel.builder(
            options: FlutterCarouselOptions(
              height: 163,
              showIndicator: false,
              enableInfiniteScroll: true,
              autoPlay: true,
              viewportFraction: 0.6,
              autoPlayInterval: const Duration(seconds: 7),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              onPageChanged: (final int index, final _) =>
                  carousel1Index.value = index,
            ),
            itemCount: 3,
            itemBuilder: (
              final BuildContext context,
              final int index,
              final _,
            ) =>
                carousel1Index.value == index
                    ? Container(
                        width: 236 / 393 * mediaQuery.size.width,
                        height: 163,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 12,
                              top: 42,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 17,
                                    height: 17,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: theme.colorScheme.secondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      shadows: const <BoxShadow>[
                                        buttonShadow,
                                      ],
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 3,
                                          top: 0,
                                          child: SizedBox(
                                            width: 12,
                                            child: Text(
                                              feedbackName(index)[0],
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    feedbackName(index),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 12,
                              top: 71,
                              child: SizedBox(
                                width: 212 /
                                        (393 - 24) *
                                        (mediaQuery.size.width - 24) -
                                    24,
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: feedbackPrefix(index),
                                      ),
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: feedbackBody(index),
                                        style: TextStyle(
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: feedbackSuffix(index),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
                              top: 12,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 2.36,
                                      offset: Offset(2.95, 2.36),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Opacity(
                        opacity: 0.50,
                        child: Container(
                          width: 236 / 393 * mediaQuery.size.width,
                          height: 115,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 12,
                                top: 71,
                                child: SizedBox(
                                  width: 212,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: feedbackPrefix(
                                            index,
                                          ),
                                        ),
                                        const TextSpan(text: ' '),
                                        TextSpan(
                                          text: feedbackBody(index),
                                          style: TextStyle(
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: feedbackSuffix(
                                            index,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 42,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 17,
                                      height: 17,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: theme.colorScheme.secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        shadows: const <BoxShadow>[
                                          buttonShadow,
                                        ],
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            left: 2,
                                            top: 1,
                                            child: SizedBox(
                                              width: 12,
                                              child: Text(
                                                feedbackName(
                                                  index,
                                                )[0],
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    SizedBox(
                                      width: 48,
                                      child: Text(
                                        feedbackName(index),
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 12,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 2.36,
                                        offset: Offset(2.95, 2.36),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Opacity(
                                        opacity: 0.50,
                                        child: Container(
                                          width: 17.73,
                                          height: 17.73,
                                          decoration: const ShapeDecoration(
                                            gradient: secondaryGradient,
                                            shape: StarBorder(
                                              innerRadiusRatio: 0.38,
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
                        ),
                      ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: FlutterCarousel.builder(
            options: FlutterCarouselOptions(
              height: 163,
              showIndicator: false,
              enableInfiniteScroll: true,
              autoPlay: true,
              viewportFraction: 0.6,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              onPageChanged: (final int index, final _) =>
                  carousel2Index.value = index,
            ),
            itemCount: 3,
            itemBuilder: (
              final BuildContext context,
              final int index,
              final _,
            ) =>
                carousel2Index.value == index
                    ? Container(
                        width: 236 / 393 * mediaQuery.size.width,
                        height: 163,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 12,
                              top: 42,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 17,
                                    height: 17,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: theme.colorScheme.secondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      shadows: const <BoxShadow>[
                                        buttonShadow,
                                      ],
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 3,
                                          top: 0,
                                          child: SizedBox(
                                            width: 12,
                                            child: Text(
                                              feedbackName(
                                                index + 3,
                                              )[0],
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    feedbackName(index + 3),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 12,
                              top: 71,
                              child: SizedBox(
                                width: 212,
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: feedbackPrefix(index + 3),
                                      ),
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: feedbackBody(index + 3),
                                        style: TextStyle(
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: feedbackSuffix(index + 3),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
                              top: 12,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 2.36,
                                      offset: Offset(2.95, 2.36),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7.09),
                                    Container(
                                      width: 17.73,
                                      height: 17.73,
                                      decoration: const ShapeDecoration(
                                        gradient: secondaryGradient,
                                        shape: StarBorder(
                                          innerRadiusRatio: 0.38,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Opacity(
                        opacity: 0.50,
                        child: Container(
                          width: 236 / 393 * mediaQuery.size.width,
                          height: 115,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 12,
                                top: 71,
                                child: SizedBox(
                                  width: 212,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: feedbackPrefix(
                                            index + 3,
                                          ),
                                        ),
                                        const TextSpan(text: ' '),
                                        TextSpan(
                                          text: feedbackBody(index + 3),
                                          style: TextStyle(
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: feedbackSuffix(
                                            index + 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 42,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 17,
                                      height: 17,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: theme.colorScheme.secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        shadows: const <BoxShadow>[
                                          buttonShadow,
                                        ],
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            left: 2,
                                            top: 1,
                                            child: SizedBox(
                                              width: 12,
                                              child: Text(
                                                feedbackName(
                                                  index + 3,
                                                )[0],
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      feedbackName(index + 3),
                                      textAlign: TextAlign.center,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 12,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 2.36,
                                        offset: Offset(2.95, 2.36),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Container(
                                        width: 17.73,
                                        height: 17.73,
                                        decoration: const ShapeDecoration(
                                          gradient: secondaryGradient,
                                          shape: StarBorder(
                                            innerRadiusRatio: 0.38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7.09),
                                      Opacity(
                                        opacity: 0.50,
                                        child: Container(
                                          width: 17.73,
                                          height: 17.73,
                                          decoration: const ShapeDecoration(
                                            gradient: secondaryGradient,
                                            shape: StarBorder(
                                              innerRadiusRatio: 0.38,
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
                        ),
                      ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 14),
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
