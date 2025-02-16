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

part 'onboarding_20_statement_q1_screen.g.dart';

@TypedGoRoute<Onboarding20StatementQ1Route>(
  path: '/onboarding/20_statement_q1',
)
class Onboarding20StatementQ1Route extends GoRouteData {
  const Onboarding20StatementQ1Route();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding20StatementQ1Screen();

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
class Onboarding20StatementQ1Screen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding20StatementQ1Screen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA20StatementQ1EnUs i18n =
        I18N.of(context).onboarding.a20StatementQ1;
    final $SourceAssetsOnboarding20StatementQ1Gen assets =
        Assets.source.assets.onboarding.a20StatementQ1;

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
                  'onboarding_screen_19_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'relate1',
                    'answer': result ? 'yes' : 'no',
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setStatementQ1Result(result: result);
          if (context.mounted) {
            ref.read(onboardingProvider).requireValue.route?.go(context);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    return Container(
      padding:
          (mediaQuery.viewPadding + mediaQuery.viewInsets).copyWith(top: 0),
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        slivers: <Widget>[
          const SliverToBoxAdapter(child: OnboardingStarHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 43)),
          SliverToBoxAdapter(
            child: Container(
              height: 98,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  Text(
                    i18n.doYouRelate,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    i18n.putOffThings,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 43)),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              constraints: const BoxConstraints(
                minHeight: 300,
                maxHeight: 400,
              ),
              height: 400 / 852 * mediaQuery.size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: assets.manthinkingaboutaquestion1.provider(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 43)),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 62,
                  padding: const EdgeInsets.symmetric(horizontal: 72),
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
                          onPressed: () async => next(result: true),
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
                          child: assets.cross.svg(),
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
        ],
      ),
    );
  }
}
