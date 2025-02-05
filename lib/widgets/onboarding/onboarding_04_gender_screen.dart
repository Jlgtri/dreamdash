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

part 'onboarding_04_gender_screen.g.dart';

@TypedGoRoute<Onboarding04GenderRoute>(
  path: '/onboarding/04_gender',
)
class Onboarding04GenderRoute extends GoRouteData {
  const Onboarding04GenderRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding04GenderScreen();

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
class Onboarding04GenderScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding04GenderScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA04GenderEnUs i18n =
        I18N.of(context).onboarding.a04Gender;
    final $SourceAssetsOnboarding04GenderGen assets =
        Assets.source.assets.onboarding.a04Gender;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    });

    Future<void> next(final Gender gender) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_3_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'gender',
                    'answer': gender.name,
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setGender(gender);
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
        SliverToBoxAdapter(
          child: Container(
            height: 414 / 852 * mediaQuery.size.height,
            constraints: const BoxConstraints(minHeight: 300, maxHeight: 450),
            margin: const EdgeInsets.all(24).copyWith(bottom: 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: assets.pencilandnotepadplanningconductingasurvey1
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
                      TextSpan(
                        text: i18n.question,
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.your,
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: i18n.gender,
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
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
                    onPressed: () async => next(Gender.female),
                    style: TextButton.styleFrom(
                      overlayColor: theme.colorScheme.onSurface,
                    ),
                    child: Text(
                      i18n.options.female,
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
                    onPressed: () async => next(Gender.male),
                    style: TextButton.styleFrom(
                      overlayColor: theme.colorScheme.onSurface,
                    ),
                    child: Text(
                      i18n.options.male,
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
                    onPressed: () async => next(Gender.nonBinary),
                    style: TextButton.styleFrom(
                      overlayColor: theme.colorScheme.onSurface,
                    ),
                    child: Text(
                      i18n.options.nonBinary,
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
                    onPressed: () async => next(Gender.other),
                    style: TextButton.styleFrom(
                      overlayColor: theme.colorScheme.onSurface,
                    ),
                    child: Text(
                      i18n.options.other,
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
    );
  }
}
