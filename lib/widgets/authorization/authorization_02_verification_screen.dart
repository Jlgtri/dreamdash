import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import '../../providers/analytics.dart';
import '../../providers/authorization.dart';
import '../../providers/onboarding.dart';
import '../../routes.dart';
import '../utils.dart';

part 'authorization_02_verification_screen.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<Authorization02VerificationRoute>(
  path: '/authorization/02_verification',
)
class Authorization02VerificationRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const Authorization02VerificationRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Authorization02VerificationScreen();

  @override
  CustomTransitionPage<void> buildPage(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: build(context, state),
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
class Authorization02VerificationScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Authorization02VerificationScreen({super.key});

  /// The length of the pin code field.
  static const int pinLength = 6;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final I18NAuthorizationA02VerificationEnUs i18n =
        I18N.of(context).authorization.a02Verification;
    final $SourceAssetsAuthorization02VerificationGen assets =
        Assets.source.assets.authorization.a02Verification;

    final FocusNode pinFocusNode = useFocusNode();
    final TextEditingController pinController = useTextEditingController();
    final ValueNotifier<String> errorText = useState('');
    final ValueNotifier<bool> hasError = useState(false);

    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isLoading = useRef(false);

    Future<void> verifyOTP() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'code_entered',
                  eventProperties: <String, String>{'placement': 'login'},
                ),
              );
          final Authorization auth = ref.read(authorizationProvider.notifier);
          await auth.signInWithEmail(
            ref.read(emailProvider),
            pinController.text,
          );
          final Routes<RouteData>? route =
              await ref.read(onboardingProvider.notifier).next();
          if (context.mounted) {
            route?.go(context);
          }
        } on AuthException catch (exception) {
          errorText.value = exception.message;
        } finally {
          isLoading.value = false;
        }
      }
    }

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
      String previousPin = '';
      pinController.addListener(() async {
        if (previousPin == pinController.text) {
          return;
        }
        previousPin = pinController.text;
        if (hasError.value) {
          errorText.value = '';
        }
        if (pinController.text.length >= pinLength) {
          await verifyOTP();
        }
        if (hasError.value = errorText.value.isNotEmpty &&
            pinController.text.length >= pinLength) {
          WidgetsBinding.instance
              .addPostFrameCallback((final _) => pinFocusNode.requestFocus());
        }
      });
      pinFocusNode.addListener(
        () async => pinFocusNode.hasFocus
            ? await scrollController.scrollToBottom()
            : null,
      );
    });

    late final PinTheme defaultPinTheme;
    return CustomScrollView(
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
                  top: 34 - 8,
                  left: 24 - 8,
                  child: IconButton(
                    onPressed: context.pop,
                    icon: Padding(
                      padding: const EdgeInsets.all(8),
                      child: assets.arrowLeft.svg(
                        width: 24,
                        height: 24,
                      ),
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
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            width: 450,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Text(
                  i18n.insertCodeOrTapLink,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: i18n.pleaseEnterCode,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: ref.watch(emailProvider),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 36 * pinLength + 12 * (pinLength - 1),
                  child: Pinput(
                    length: pinLength,
                    showCursor: false,
                    controller: pinController,
                    focusNode: pinFocusNode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    defaultPinTheme: defaultPinTheme = PinTheme(
                      width: hasError.value ? 36 + 4 * 2 : 36,
                      height: hasError.value ? 48 + 4 * 2 : 48,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(9.10),
                      ),
                      textStyle: theme.textTheme.titleLarge?.copyWith(
                          // color: hasError.value
                          //     ? theme.colorScheme.error
                          //     : null,
                          ),
                    ),
                    focusedPinTheme: defaultPinTheme.copyDecorationWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    submittedPinTheme: defaultPinTheme.copyDecorationWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                    separatorBuilder: (final _) => const SizedBox(width: 12),
                    errorPinTheme: defaultPinTheme.copyDecorationWith(
                      border: Border.all(
                        width: 4,
                        color: theme.colorScheme.error.withValues(alpha: 0.33),
                      ),
                    ),
                    errorText: errorText.value.isEmpty ? null : errorText.value,
                    forceErrorState: hasError.value,
                    errorBuilder: (final String? errorText, final String pin) =>
                        SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          errorText ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              // color: theme.colorScheme.error
                              //     .withValues(alpha: 0.9),
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
