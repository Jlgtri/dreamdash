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

part 'onboarding_02_introduction_screen.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<Onboarding02IntroductionRoute>(
  path: '/onboarding/02_introduction',
)
class Onboarding02IntroductionRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const Onboarding02IntroductionRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding02IntroductionScreen();

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

class Onboarding02IntroductionScreen extends HookConsumerWidget {
  const Onboarding02IntroductionScreen({super.key});

  static const Routes<Onboarding02IntroductionRoute> route =
      Routes.onboarding02Introduction;

  static final RegExp nameRegex = RegExp('.+');

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA02IntroductionEnUs i18n =
        I18N.of(context).onboarding.a02Introduction;
    final $SourceAssetsOnboarding02IntroductionGen assets =
        Assets.source.assets.onboarding.a02Introduction;

    final ScrollController scrollController = useScrollController();
    final FocusNode nameFocusNode = useFocusNode();
    final TextEditingController nameController =
        useTextEditingController(text: '');
    final ValueNotifier<bool> nameValid = useState(false);
    final ObjectRef<bool> isLoading = useRef(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
      nameController.addListener(
        () => nameValid.value = nameRegex.hasMatch(nameController.text),
      );
      nameFocusNode.addListener(
        () async => nameFocusNode.hasFocus
            ? await scrollController.scrollToBottom()
            : null,
      );
    });

    Future<void> next() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_1_clicked',
                  eventProperties: <String, String>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'name',
                    'answer': 'continue',
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setName(nameController.text);
          if (context.mounted) {
            ref.read(onboardingProvider).requireValue.route?.go(context);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    final EdgeInsets horizontalPadding = EdgeInsets.only(
      left: mediaQuery.padding.left + 24,
      right: mediaQuery.padding.right + 24,
    );
    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Container(
            padding: horizontalPadding,
            constraints: const BoxConstraints(
              minHeight: 220,
              maxHeight: 400,
            ),
            height: 400 / 852 * mediaQuery.size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: assets.introduction.provider(),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverToBoxAdapter(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: i18n.whatIs),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: i18n.yourName,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const TextSpan(text: '?'),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              width: 450,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    focusNode: nameFocusNode,
                    clipBehavior: Clip.antiAlias,
                    style: theme.textTheme.bodyMedium,
                    cursorColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    onTapOutside: (final _) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      hintText: i18n.placeholder,
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                      constraints: const BoxConstraints(maxWidth: 450),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 64)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      assets.lock.svg(),
                      const SizedBox(width: 8),
                      Text(
                        i18n.respectPrivacy,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Opacity(
                    opacity: nameValid.value ? 1 : 0.80,
                    child: Container(
                      width: 450,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: TextButton(
                        onPressed: nameValid.value ? next : null,
                        child: Text(
                          i18n.submit,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
