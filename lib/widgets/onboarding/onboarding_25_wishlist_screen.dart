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

part 'onboarding_25_wishlist_screen.g.dart';

@TypedGoRoute<Onboarding25WishlistRoute>(
  path: '/onboarding/25_wishlist',
)
class Onboarding25WishlistRoute extends GoRouteData {
  const Onboarding25WishlistRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding25WishlistScreen();

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
class Onboarding25WishlistScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding25WishlistScreen({super.key});

  static final RegExp regex = RegExp('.+');

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA25WishlistEnUs i18n =
        I18N.of(context).onboarding.a25Wishlist;
    final $SourceAssetsOnboarding25WishlistGen assets =
        Assets.source.assets.onboarding.a25Wishlist;

    final FocusNode focusNode1 = useFocusNode();
    final TextEditingController textController1 =
        useTextEditingController(text: '');

    final FocusNode focusNode2 = useFocusNode();
    final TextEditingController textController2 =
        useTextEditingController(text: '');

    final FocusNode focusNode3 = useFocusNode();
    final TextEditingController textController3 =
        useTextEditingController(text: '');

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    final ValueNotifier<bool> isValid = useState(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
      textController1.addListener(
        () => isValid.value = regex.hasMatch(textController1.text) &&
            regex.hasMatch(textController2.text) &&
            regex.hasMatch(textController3.text),
      );
      textController2.addListener(
        () => isValid.value = regex.hasMatch(textController1.text) &&
            regex.hasMatch(textController2.text) &&
            regex.hasMatch(textController3.text),
      );
      textController3.addListener(
        () => isValid.value = regex.hasMatch(textController1.text) &&
            regex.hasMatch(textController2.text) &&
            regex.hasMatch(textController3.text),
      );
      focusNode1.addListener(
        () async => focusNode1.hasPrimaryFocus
            ? await scrollController.scrollToBottom()
            : textController1.selection =
                const TextSelection.collapsed(offset: 0),
      );
      focusNode2.addListener(
        () async => focusNode2.hasPrimaryFocus
            ? await scrollController.scrollToBottom()
            : textController2.selection =
                const TextSelection.collapsed(offset: 0),
      );
      focusNode3.addListener(
        () async => focusNode3.hasPrimaryFocus
            ? await scrollController.scrollToBottom()
            : textController3.selection =
                const TextSelection.collapsed(offset: 0),
      );
    });

    Future<void> next(final List<String> wishlist) async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_24_clicked',
                  eventProperties: <String, Object?>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'wish_list',
                    'entered_text': wishlist,
                  },
                ),
              );
          final Onboarding onboarding = ref.read(onboardingProvider.notifier);
          await onboarding.setWishlist(wishlist);
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
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              width: 293,
              height: 47,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 246,
                    child: Text(
                      i18n.createWishlist,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  assets.star31.svg(),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              i18n.lifeAdvice,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textController1,
                  focusNode: focusNode1,
                  clipBehavior: Clip.antiAlias,
                  style: theme.textTheme.bodyMedium,
                  cursorColor:
                      theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  onTapOutside: (final _) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 18,
                          height: 22,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: assets.star32.svg(),
                        ),
                      ],
                    ),
                    hintText: i18n.wishListItems.item1,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: textController2,
                  focusNode: focusNode2,
                  clipBehavior: Clip.antiAlias,
                  style: theme.textTheme.bodyMedium,
                  cursorColor:
                      theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  onTapOutside: (final _) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    hintText: i18n.wishListItems.item2,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 18,
                          height: 22,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: assets.star32.svg(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: textController3,
                  focusNode: focusNode3,
                  clipBehavior: Clip.antiAlias,
                  style: theme.textTheme.bodyMedium,
                  cursorColor:
                      theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  onTapOutside: (final _) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    hintText: i18n.wishListItems.item3,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 18,
                          height: 22,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: assets.star32.svg(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              i18n.helpQuestions,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Opacity(
                opacity: isValid.value ? 1 : 0.8,
                child: Container(
                  width: 450,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: ShapeDecoration(
                    color: theme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: TextButton(
                    onPressed: isValid.value
                        ? () async => next(<String>[
                              textController1.text,
                              textController2.text,
                              textController3.text,
                            ])
                        : null,
                    child: Text(
                      i18n.buttonText,
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
      ],
    );
  }
}
