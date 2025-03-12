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

part 'onboarding_05_age_screen.g.dart';

@TypedGoRoute<Onboarding05AgeRoute>(path: '/onboarding/05_age')
class Onboarding05AgeRoute extends GoRouteData {
  const Onboarding05AgeRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding05AgeScreen();

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
class Onboarding05AgeScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding05AgeScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA05AgeEnUs i18n = I18N.of(context).onboarding.a05Age;
    final $SourceAssetsOnboarding05AgeGen assets =
        Assets.source.assets.onboarding.a05Age;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    });

    Future<void> next(final Age age) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref
              .read(analyticsProvider.notifier)
              .track(
                BaseEvent(
                  'onboarding_screen_4_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'age',
                    'answer': age.name,
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setAge(age);
          if (context.mounted) {
            ref.read(onboardingProvider).requireValue.route?.go(context);
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
          SliverToBoxAdapter(
            child: Container(
              height: 414 / 852 * mediaQuery.size.height - 24,
              constraints: const BoxConstraints(
                minHeight: 300,
                maxHeight: 450,
              ),
              margin: const EdgeInsets.all(24).copyWith(bottom: 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      assets.pencilandnotepadplanningconductingasurvey1
                          .provider(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: i18n.question),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.your,
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: i18n.age,
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                        TextSpan(text: i18n.questionMark),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async => next(Age.a18_25),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                      ),
                      child: Text(
                        i18n.options.age1825,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async => next(Age.a26_35),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                      ),
                      child: Text(
                        i18n.options.age2635,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async => next(Age.a36_45),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                      ),
                      child: Text(
                        i18n.options.age3645,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async => next(Age.a46_55),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                      ),
                      child: Text(
                        i18n.options.age4655,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async => next(Age.a55_),
                      style: TextButton.styleFrom(
                        overlayColor: theme.colorScheme.onSurface,
                      ),
                      child: Text(
                        i18n.options.age56Plus,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge,
                      ),
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
