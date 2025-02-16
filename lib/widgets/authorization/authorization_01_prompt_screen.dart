import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:supabase/supabase.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/authorization.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'authorization_01_prompt_screen.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<Authorization01PromptRoute>(path: '/authorization/01_prompt')
class Authorization01PromptRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const Authorization01PromptRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Authorization01PromptScreen();

  @override
  CustomTransitionPage<void> buildPage(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      CustomTransitionPage<void>(
        child: build(context, state),
        transitionsBuilder: (
          final BuildContext context,
          final Animation<double> animation,
          final Animation<double> secondaryAnimation,
          final Widget child,
        ) =>
            FadeTransition(opacity: animation, child: child),
        key: state.pageKey,
      );
}

/// The welcome screen of the onboarding flow.
class Authorization01PromptScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Authorization01PromptScreen({super.key});

  static final RegExp emailRegex = RegExp('.+@.+');

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final I18NAuthorizationA01PromptEnUs i18n =
        I18N.of(context).authorization.a01Prompt;
    final $SourceAssetsAuthorization01PromptGen assets =
        Assets.source.assets.authorization.a01Prompt;

    final FocusNode emailFocusNode = useFocusNode();
    final TextEditingController emailController =
        useTextEditingController(text: '');
    final ValueNotifier<String> hasError = useState('');

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    final bool emailValid = ref
        .watch(emailProvider.select((final String value) => value.isNotEmpty));

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
      emailController.addListener(
        () => emailRegex.hasMatch(emailController.text)
            ? ref.read(emailProvider.notifier).state = emailController.text
            : null,
      );
      emailFocusNode.addListener(
        () async => emailFocusNode.hasFocus
            ? await scrollController.scrollToBottom()
            : null,
      );
    });

    Future<void> signInWithGoogle() async {
      if (!isLoading.value) {
        isLoading.value = true;
        final OnboardingState onboarding =
            await ref.read(onboardingProvider.future);
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'sign_in_button_clicked',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'google',
                  },
                ),
              );
          await ref.read(authorizationProvider.notifier).signInWithGoogle();
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'login_success',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'apple',
                  },
                ),
              );
        } on AuthException catch (exception) {
          hasError.value = exception.message;
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'login_invalid',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'apple',
                    'message': exception.message,
                  },
                ),
              );
        } finally {
          isLoading.value = false;
        }
      }
    }

    Future<void> signInWithApple() async {
      if (!isLoading.value) {
        isLoading.value = true;
        final OnboardingState onboarding =
            await ref.read(onboardingProvider.future);
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'sign_in_button_clicked',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'apple',
                  },
                ),
              );
          await ref.read(authorizationProvider.notifier).signInWithApple();
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'login_success',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'apple',
                  },
                ),
              );
        } on AuthException catch (exception) {
          hasError.value = exception.message;
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'login_invalid',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'google',
                    'message': exception.message,
                  },
                ),
              );
        } finally {
          isLoading.value = false;
        }
      }
    }

    Future<void> signInWithEmail() async {
      if (!isLoading.value) {
        isLoading.value = true;
        final OnboardingState onboarding =
            await ref.read(onboardingProvider.future);
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'sign_in_button_clicked',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'email',
                  },
                ),
              );
          final Authorization auth = ref.read(authorizationProvider.notifier);
          await auth.signInWithOtp(emailController.text.trim());
          if (context.mounted) {
            await Routes.authorization02Verification.push(context);
          }
        } on AuthException catch (exception) {
          hasError.value = exception.message;
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'login_invalid',
                  eventProperties: <String, String>{
                    'placement': onboarding.route == null ? 'profile' : 'login',
                    'way': 'email',
                    'message': exception.message,
                  },
                ),
              );
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
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 273,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      height: 273,
                      child: assets.vector1.svg(
                        width: mediaQuery.size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: mediaQuery.size.width / 2 - 300 / 2,
                    top: 106,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SimpleShadow(
                          opacity: 0.1,
                          offset: const Offset(10.26, 12.83),
                          sigma: 3.42,
                          child: assets.star31.svg(),
                        ),
                        const SizedBox(width: 12),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: i18n.dream,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              TextSpan(text: i18n.dash),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFFBD080),
                            fontSize: 27.94,
                            fontFamily: 'Verdana',
                            fontWeight: FontWeight.w700,
                            height: 0.01,
                            letterSpacing: -0.19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 34,
                    left: 114 / 393 * mediaQuery.size.width,
                    child: assets.star32.svg(),
                  ),
                  Positioned(
                    top: 160,
                    left: 259 / 393 * mediaQuery.size.width,
                    child: assets.star33.svg(),
                  ),
                  Positioned(
                    top: 202,
                    left: 201 / 393 * mediaQuery.size.width,
                    child: assets.star34.svg(),
                  ),
                  Positioned(
                    left: 76 / 393 * mediaQuery.size.width,
                    top: 78,
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
                    left: 175 / 393 * mediaQuery.size.width,
                    top: 70,
                    child: Container(
                      width: 6,
                      height: 5.14,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20 / 393 * mediaQuery.size.width,
                    top: 90,
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 257 / 393 * mediaQuery.size.width,
                    top: 220,
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
                    left: 337 / 393 * mediaQuery.size.width,
                    top: 148,
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
                    left: 146 / 393 * mediaQuery.size.width,
                    top: 186,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF1B8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 327 / 393 * mediaQuery.size.width,
                    top: 197,
                    child: Container(
                      width: 6,
                      height: 5.14,
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
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      i18n.getBackToProgress,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    i18n.signInToAccount,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.secondary),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 450,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Theme(
                              data: ThemeData(
                                textSelectionTheme: TextSelectionThemeData(
                                  selectionColor: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                  selectionHandleColor: theme
                                      .colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              child: TextField(
                                controller: emailController,
                                focusNode: emailFocusNode,
                                clipBehavior: Clip.antiAlias,
                                style: theme.textTheme.bodyMedium,
                                cursorColor: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                onSubmitted: emailValid
                                    ? (final _) async => signInWithEmail()
                                    : null,
                                // onTapOutside: (final _) => FocusManager
                                //     .instance.primaryFocus
                                //     ?.unfocus(),
                                decoration: InputDecoration(
                                  errorStyle:
                                      theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                  errorText: hasError.value.isEmpty
                                      ? null
                                      : hasError.value,
                                  prefixIconConstraints: const BoxConstraints(
                                    maxHeight: 18,
                                    maxWidth: 18 + 12 * 2,
                                  ),
                                  prefixIcon: Center(
                                    child: SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: assets.email.svg(),
                                    ),
                                  ),
                                  hintText: i18n.email,
                                  hintStyle:
                                      theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.3),
                                  ),
                                  isDense: true,
                                  constraints: const BoxConstraints(
                                    maxWidth: 450,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 13,
                                  ),
                                  filled: true,
                                  fillColor: theme.colorScheme.primaryContainer,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(9.10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(9.10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(9.10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Opacity(
                    opacity: emailValid ? 1 : 0.8,
                    child: Container(
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
                        onPressed: emailValid ? signInWithEmail : null,
                        child: Text(
                          i18n.buttonText,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 22,
                    width: 450,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            height: 1,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          i18n.orSignInVia,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Divider(
                            height: 1,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: signInWithApple,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          assets.apple.svg(),
                          const SizedBox(width: 12),
                          Text(
                            i18n.signInWithApple,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 450,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const <BoxShadow>[buttonShadow],
                    ),
                    child: TextButton(
                      onPressed: signInWithGoogle,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          assets.google.svg(),
                          const SizedBox(width: 12),
                          Text(
                            i18n.google,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
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
