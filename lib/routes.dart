import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'generated/i18n.g.dart';
import 'providers/authorization.dart';
import 'providers/onboarding.dart';
import 'widgets/authorization/authorization_01_prompt_screen.dart';
import 'widgets/authorization/authorization_02_verification_screen.dart';
import 'widgets/onboarding/onboarding_00_splash_screen.dart';
import 'widgets/onboarding/onboarding_01_welcome_screen.dart';
import 'widgets/onboarding/onboarding_02_introduction_screen.dart';
import 'widgets/onboarding/onboarding_03_greeting_screen.dart';
import 'widgets/onboarding/onboarding_04_gender_screen.dart';
import 'widgets/onboarding/onboarding_05_age_screen.dart';
import 'widgets/onboarding/onboarding_06_info_screen.dart';
import 'widgets/onboarding/onboarding_07_motivation_q1_screen.dart';
import 'widgets/onboarding/onboarding_08_motivation_q2_screen.dart';
import 'widgets/onboarding/onboarding_09_motivation_q3_screen.dart';
import 'widgets/onboarding/onboarding_10_motivation_level_screen.dart';
import 'widgets/onboarding/onboarding_11_progress_screen.dart';
import 'widgets/onboarding/onboarding_12_mental_health_q1_screen.dart';
import 'widgets/onboarding/onboarding_13_mental_health_q2_screen.dart';
import 'widgets/onboarding/onboarding_14_mental_health_q3_screen.dart';
import 'widgets/onboarding/onboarding_15_mental_health_q4_screen.dart';
import 'widgets/onboarding/onboarding_16_mental_health_q5_screen.dart';
import 'widgets/onboarding/onboarding_17_info_2_screen.dart';
import 'widgets/onboarding/onboarding_18_comparison_screen.dart';
import 'widgets/onboarding/onboarding_19_journey_screen.dart';
import 'widgets/onboarding/onboarding_20_statement_q1_screen.dart';
import 'widgets/onboarding/onboarding_21_statement_q2_screen.dart';
import 'widgets/onboarding/onboarding_22_motivation_progress_screen.dart';
import 'widgets/onboarding/onboarding_23_testimonials_screen.dart';
import 'widgets/onboarding/onboarding_24_task_screen.dart';
import 'widgets/onboarding/onboarding_25_wishlist_screen.dart';
import 'widgets/onboarding/onboarding_26_commitment_screen.dart';
import 'widgets/onboarding/onboarding_27_notification_screen.dart';
import 'widgets/onboarding/onboarding_28_promise_screen.dart';
import 'widgets/onboarding/onboarding_29_chat_screen.dart';
import 'widgets/onboarding/onboarding_30_paywall_screen.dart';
import 'widgets/utils.dart';

part 'routes.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<RootRoute>(path: '/')
class RootRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const RootRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      throw UnimplementedError();
}

/// The route in the app.
enum Routes<Route extends RouteData> {
  authorization01Prompt(
    Authorization01PromptRoute(),
    key: PageStorageKey<String>('Authorization01PromptScreen'),
  ),
  authorization02Verification(
    Authorization02VerificationRoute(),
    key: PageStorageKey<String>('Authorization02VerificationScreen'),
  ),

  /// The home screen.
  ///
  /// **Can** be provided with [Onboarding00SplashScreen] as an argument.
  onboarding00Splash(
    Onboarding00SplashRoute(),
    key: PageStorageKey<String>('Onboarding00SplashScreen'),
  ),

  /// The home screen.
  ///
  /// **Can** be provided with [Onboarding01WelcomeScreen] as an argument.
  onboarding01Welcome(
    Onboarding01WelcomeRoute(),
    key: PageStorageKey<String>('Onboarding01WelcomeScreen'),
  ),
  onboarding02Introduction(
    Onboarding02IntroductionRoute(),
    key: PageStorageKey<String>('Onboarding02IntroductionScreen'),
  ),
  onboarding03Greeting(
    Onboarding03GreetingRoute(),
    key: PageStorageKey<String>('Onboarding03GreetingScreen'),
  ),
  onboarding04Gender(
    Onboarding04GenderRoute(),
    key: PageStorageKey<String>('Onboarding04GenderScreen'),
  ),
  onboarding05Age(
    Onboarding05AgeRoute(),
    key: PageStorageKey<String>('Onboarding05AgeScreen'),
  ),
  onboarding06Info(
    Onboarding06InfoRoute(),
    key: PageStorageKey<String>('Onboarding06InfoScreen'),
  ),
  onboarding07MotivationQ1(
    Onboarding07MotivationQ1Route(),
    key: PageStorageKey<String>('Onboarding07MotivationQ1Screen'),
  ),
  onboarding08MotivationQ2(
    Onboarding08MotivationQ2Route(),
    key: PageStorageKey<String>('Onboarding08MotivationQ2Screen'),
  ),
  onboarding09MotivationQ3(
    Onboarding09MotivationQ3Route(),
    key: PageStorageKey<String>('Onboarding09MotivationQ3Screen'),
  ),
  onboarding10MotivationLevel(
    Onboarding10MotivationLevelRoute(),
    key: PageStorageKey<String>('Onboarding10MotivationLevelScreen'),
  ),
  onboarding11Progress(
    Onboarding11ProgressRoute(),
    key: PageStorageKey<String>('Onboarding11ProgressScreen'),
  ),
  onboarding12MentalHealthQ1(
    Onboarding12MentalHealthQ1Route(),
    key: PageStorageKey<String>('Onboarding12MentalHealthQ1Screen'),
  ),
  onboarding13MentalHealthQ2(
    Onboarding13MentalHealthQ2Route(),
    key: PageStorageKey<String>('Onboarding13MentalHealthQ2Screen'),
  ),
  onboarding14MentalHealthQ3(
    Onboarding14MentalHealthQ3Route(),
    key: PageStorageKey<String>('Onboarding14MentalHealthQ3Screen'),
  ),
  onboarding15MentalHealthQ4(
    Onboarding15MentalHealthQ4Route(),
    key: PageStorageKey<String>('Onboarding15MentalHealthQ4Screen'),
  ),
  onboarding16MentalHealthQ5(
    Onboarding16MentalHealthQ5Route(),
    key: PageStorageKey<String>('Onboarding16MentalHealthQ5Screen'),
  ),
  onboarding17Info2(
    Onboarding17Info2Route(),
    key: PageStorageKey<String>('Onboarding17Info2Screen'),
  ),
  onboarding18Comparison(
    Onboarding18ComparisonRoute(),
    key: PageStorageKey<String>('Onboarding18ComparisonScreen'),
  ),
  onboarding19Journey(
    Onboarding19JourneyRoute(),
    key: PageStorageKey<String>('Onboarding19JourneyScreen'),
  ),
  onboarding20StatementQ1(
    Onboarding20StatementQ1Route(),
    key: PageStorageKey<String>('Onboarding20StatementQ1Screen'),
  ),
  onboarding21StatementQ2(
    Onboarding21StatementQ2Route(),
    key: PageStorageKey<String>('Onboarding21StatementQ2Screen'),
  ),
  onboarding22MotivationProgress(
    Onboarding22MotivationProgressRoute(),
    key: PageStorageKey<String>('Onboarding22MotivationProgressScreen'),
  ),
  onboarding23Testimonials(
    Onboarding23TestimonialsRoute(),
    key: PageStorageKey<String>('Onboarding23TestimonialsScreen'),
  ),
  onboarding24Task(
    Onboarding24TaskRoute(),
    key: PageStorageKey<String>('Onboarding24TaskScreen'),
  ),
  onboarding25Wishlist(
    Onboarding25WishlistRoute(),
    key: PageStorageKey<String>('Onboarding25WishlistScreen'),
  ),
  onboarding26Commitment(
    Onboarding26CommitmentRoute(),
    key: PageStorageKey<String>('Onboarding26CommitmentScreen'),
  ),
  onboarding27Notification(
    Onboarding27NotificationRoute(),
    key: PageStorageKey<String>('Onboarding27NotificationScreen'),
  ),
  onboarding28Promise(
    Onboarding28PromiseRoute(),
    key: PageStorageKey<String>('Onboarding28PromiseScreen'),
  ),
  onboarding29Chat(
    Onboarding29ChatRoute(),
    key: PageStorageKey<String>('Onboarding29ChatScreen'),
  ),
  onboarding30Paywall(
    Onboarding30PaywallRoute(),
    key: PageStorageKey<String>('Onboarding30PaywallScreen'),
  );

  /// The route in the app.
  const Routes(this._route, {this.key});

  /// The name of this route.
  Route get route => _route!;
  final Route? _route;

  /// The key for this route.
  final Key? key;

  /// Return the current route depending on app's state.
  static Future<Routes<RouteData>> current(
    final ProviderContainer container,
  ) async {
    await container.read(authorizationProvider.future);
    final OnboardingState onboarding =
        await container.read(onboardingProvider.future);
    return onboarding.route!;
  }

  /// The navigator key to pass to children of this route.
  GlobalKey<NavigatorState>? get navigatorKey {
    switch (this) {
      case authorization01Prompt:
      case authorization02Verification:
      case onboarding00Splash:
      case onboarding01Welcome:
      case onboarding02Introduction:
      case onboarding03Greeting:
      case onboarding04Gender:
      case onboarding05Age:
      case onboarding06Info:
      case onboarding07MotivationQ1:
      case onboarding08MotivationQ2:
      case onboarding09MotivationQ3:
      case onboarding10MotivationLevel:
      case onboarding11Progress:
      case onboarding12MentalHealthQ1:
      case onboarding13MentalHealthQ2:
      case onboarding14MentalHealthQ3:
      case onboarding15MentalHealthQ4:
      case onboarding16MentalHealthQ5:
      case onboarding17Info2:
      case onboarding18Comparison:
      case onboarding19Journey:
      case onboarding20StatementQ1:
      case onboarding21StatementQ2:
      case onboarding22MotivationProgress:
      case onboarding23Testimonials:
      case onboarding24Task:
      case onboarding25Wishlist:
      case onboarding26Commitment:
      case onboarding27Notification:
      case onboarding28Promise:
      case onboarding29Chat:
      case onboarding30Paywall:
    }
    return null;
  }

  String get location {
    switch (this) {
      case authorization01Prompt:
        return authorization01Prompt.route.location;
      case authorization02Verification:
        return authorization02Verification.route.location;
      case onboarding00Splash:
        return onboarding00Splash.route.location;
      case onboarding01Welcome:
        return onboarding01Welcome.route.location;
      case onboarding02Introduction:
        return onboarding02Introduction.route.location;
      case onboarding03Greeting:
        return onboarding03Greeting.route.location;
      case onboarding04Gender:
        return onboarding04Gender.route.location;
      case onboarding05Age:
        return onboarding05Age.route.location;
      case onboarding06Info:
        return onboarding06Info.route.location;
      case onboarding07MotivationQ1:
        return onboarding07MotivationQ1.route.location;
      case onboarding08MotivationQ2:
        return onboarding08MotivationQ2.route.location;
      case onboarding09MotivationQ3:
        return onboarding09MotivationQ3.route.location;
      case onboarding10MotivationLevel:
        return onboarding10MotivationLevel.route.location;
      case onboarding11Progress:
        return onboarding11Progress.route.location;
      case onboarding12MentalHealthQ1:
        return onboarding12MentalHealthQ1.route.location;
      case onboarding13MentalHealthQ2:
        return onboarding13MentalHealthQ2.route.location;
      case onboarding14MentalHealthQ3:
        return onboarding14MentalHealthQ3.route.location;
      case onboarding15MentalHealthQ4:
        return onboarding15MentalHealthQ4.route.location;
      case onboarding16MentalHealthQ5:
        return onboarding16MentalHealthQ5.route.location;
      case onboarding17Info2:
        return onboarding17Info2.route.location;
      case onboarding18Comparison:
        return onboarding18Comparison.route.location;
      case onboarding19Journey:
        return onboarding19Journey.route.location;
      case onboarding20StatementQ1:
        return onboarding20StatementQ1.route.location;
      case onboarding21StatementQ2:
        return onboarding21StatementQ2.route.location;
      case onboarding22MotivationProgress:
        return onboarding22MotivationProgress.route.location;
      case onboarding23Testimonials:
        return onboarding23Testimonials.route.location;
      case onboarding24Task:
        return onboarding24Task.route.location;
      case onboarding25Wishlist:
        return onboarding25Wishlist.route.location;
      case onboarding26Commitment:
        return onboarding26Commitment.route.location;
      case onboarding27Notification:
        return onboarding27Notification.route.location;
      case onboarding28Promise:
        return onboarding28Promise.route.location;
      case onboarding29Chat:
        return onboarding29Chat.route.location;
      case onboarding30Paywall:
        return onboarding30Paywall.route.location;
    }
  }

  void go(final BuildContext context) {
    switch (this) {
      case authorization01Prompt:
        return authorization01Prompt.route.go(context);
      case authorization02Verification:
        return authorization02Verification.route.go(context);
      case onboarding00Splash:
        return onboarding00Splash.route.go(context);
      case onboarding01Welcome:
        return onboarding01Welcome.route.go(context);
      case onboarding02Introduction:
        return onboarding02Introduction.route.go(context);
      case onboarding03Greeting:
        return onboarding03Greeting.route.go(context);
      case onboarding04Gender:
        return onboarding04Gender.route.go(context);
      case onboarding05Age:
        return onboarding05Age.route.go(context);
      case onboarding06Info:
        return onboarding06Info.route.go(context);
      case onboarding07MotivationQ1:
        return onboarding07MotivationQ1.route.go(context);
      case onboarding08MotivationQ2:
        return onboarding08MotivationQ2.route.go(context);
      case onboarding09MotivationQ3:
        return onboarding09MotivationQ3.route.go(context);
      case onboarding10MotivationLevel:
        return onboarding10MotivationLevel.route.go(context);
      case onboarding11Progress:
        return onboarding11Progress.route.go(context);
      case onboarding12MentalHealthQ1:
        return onboarding12MentalHealthQ1.route.go(context);
      case onboarding13MentalHealthQ2:
        return onboarding13MentalHealthQ2.route.go(context);
      case onboarding14MentalHealthQ3:
        return onboarding14MentalHealthQ3.route.go(context);
      case onboarding15MentalHealthQ4:
        return onboarding15MentalHealthQ4.route.go(context);
      case onboarding16MentalHealthQ5:
        return onboarding16MentalHealthQ5.route.go(context);
      case onboarding17Info2:
        return onboarding17Info2.route.go(context);
      case onboarding18Comparison:
        return onboarding18Comparison.route.go(context);
      case onboarding19Journey:
        return onboarding19Journey.route.go(context);
      case onboarding20StatementQ1:
        return onboarding20StatementQ1.route.go(context);
      case onboarding21StatementQ2:
        return onboarding21StatementQ2.route.go(context);
      case onboarding22MotivationProgress:
        return onboarding22MotivationProgress.route.go(context);
      case onboarding23Testimonials:
        return onboarding23Testimonials.route.go(context);
      case onboarding24Task:
        return onboarding24Task.route.go(context);
      case onboarding25Wishlist:
        return onboarding25Wishlist.route.go(context);
      case onboarding26Commitment:
        return onboarding26Commitment.route.go(context);
      case onboarding27Notification:
        return onboarding27Notification.route.go(context);
      case onboarding28Promise:
        return onboarding28Promise.route.go(context);
      case onboarding29Chat:
        return onboarding29Chat.route.go(context);
      case onboarding30Paywall:
        return onboarding30Paywall.route.go(context);
    }
  }

  Future<T?> push<T extends Object?>(final BuildContext context) {
    switch (this) {
      case authorization01Prompt:
        return context.push<T>(authorization01Prompt.location);
      case authorization02Verification:
        return context.push<T>(authorization02Verification.location);
      case onboarding00Splash:
        return context.push<T>(onboarding00Splash.location);
      case onboarding01Welcome:
        return context.push<T>(onboarding01Welcome.location);
      case onboarding02Introduction:
        return context.push<T>(onboarding02Introduction.location);
      case onboarding03Greeting:
        return context.push<T>(onboarding03Greeting.location);
      case onboarding04Gender:
        return context.push<T>(onboarding04Gender.location);
      case onboarding05Age:
        return context.push<T>(onboarding05Age.location);
      case onboarding06Info:
        return context.push<T>(onboarding06Info.location);
      case onboarding07MotivationQ1:
        return context.push<T>(onboarding07MotivationQ1.location);
      case onboarding08MotivationQ2:
        return context.push<T>(onboarding08MotivationQ2.location);
      case onboarding09MotivationQ3:
        return context.push<T>(onboarding09MotivationQ3.location);
      case onboarding10MotivationLevel:
        return context.push<T>(onboarding10MotivationLevel.location);
      case onboarding11Progress:
        return context.push<T>(onboarding11Progress.location);
      case onboarding12MentalHealthQ1:
        return context.push<T>(onboarding12MentalHealthQ1.location);
      case onboarding13MentalHealthQ2:
        return context.push<T>(onboarding13MentalHealthQ2.location);
      case onboarding14MentalHealthQ3:
        return context.push<T>(onboarding14MentalHealthQ3.location);
      case onboarding15MentalHealthQ4:
        return context.push<T>(onboarding15MentalHealthQ4.location);
      case onboarding16MentalHealthQ5:
        return context.push<T>(onboarding16MentalHealthQ5.location);
      case onboarding17Info2:
        return context.push<T>(onboarding17Info2.location);
      case onboarding18Comparison:
        return context.push<T>(onboarding18Comparison.location);
      case onboarding19Journey:
        return context.push<T>(onboarding19Journey.location);
      case onboarding20StatementQ1:
        return context.push<T>(onboarding20StatementQ1.location);
      case onboarding21StatementQ2:
        return context.push<T>(onboarding21StatementQ2.location);
      case onboarding22MotivationProgress:
        return context.push<T>(onboarding22MotivationProgress.location);
      case onboarding23Testimonials:
        return context.push<T>(onboarding23Testimonials.location);
      case onboarding24Task:
        return context.push<T>(onboarding24Task.location);
      case onboarding25Wishlist:
        return context.push<T>(onboarding25Wishlist.location);
      case onboarding26Commitment:
        return context.push<T>(onboarding26Commitment.location);
      case onboarding27Notification:
        return context.push<T>(onboarding27Notification.location);
      case onboarding28Promise:
        return context.push<T>(onboarding28Promise.location);
      case onboarding29Chat:
        return context.push<T>(onboarding29Chat.location);
      case onboarding30Paywall:
        return context.push<T>(onboarding30Paywall.location);
    }
  }

  Future<T?> pushReplacement<T extends Object?>(
    final BuildContext context, {
    final Object? extra,
  }) {
    switch (this) {
      case authorization01Prompt:
        return GoRouter.of(context)
            .pushReplacement<T>(authorization01Prompt.location, extra: extra);
      case authorization02Verification:
        return GoRouter.of(context).pushReplacement<T>(
          authorization02Verification.location,
          extra: extra,
        );
      case onboarding00Splash:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding00Splash.location,
          extra: extra,
        );
      case onboarding01Welcome:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding01Welcome.location, extra: extra);
      case onboarding02Introduction:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding02Introduction.location,
          extra: extra,
        );
      case onboarding03Greeting:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding03Greeting.location, extra: extra);
      case onboarding04Gender:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding04Gender.location, extra: extra);
      case onboarding05Age:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding05Age.location, extra: extra);
      case onboarding06Info:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding06Info.location, extra: extra);
      case onboarding07MotivationQ1:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding07MotivationQ1.location,
          extra: extra,
        );
      case onboarding08MotivationQ2:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding08MotivationQ2.location,
          extra: extra,
        );
      case onboarding09MotivationQ3:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding09MotivationQ3.location,
          extra: extra,
        );
      case onboarding10MotivationLevel:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding10MotivationLevel.location,
          extra: extra,
        );
      case onboarding11Progress:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding11Progress.location, extra: extra);
      case onboarding12MentalHealthQ1:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding12MentalHealthQ1.location,
          extra: extra,
        );
      case onboarding13MentalHealthQ2:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding13MentalHealthQ2.location,
          extra: extra,
        );
      case onboarding14MentalHealthQ3:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding14MentalHealthQ3.location,
          extra: extra,
        );
      case onboarding15MentalHealthQ4:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding15MentalHealthQ4.location,
          extra: extra,
        );
      case onboarding16MentalHealthQ5:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding16MentalHealthQ5.location,
          extra: extra,
        );
      case onboarding17Info2:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding17Info2.location, extra: extra);
      case onboarding18Comparison:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding18Comparison.location, extra: extra);
      case onboarding19Journey:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding19Journey.location, extra: extra);
      case onboarding20StatementQ1:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding20StatementQ1.location, extra: extra);
      case onboarding21StatementQ2:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding21StatementQ2.location, extra: extra);
      case onboarding22MotivationProgress:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding22MotivationProgress.location,
          extra: extra,
        );
      case onboarding23Testimonials:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding23Testimonials.location,
          extra: extra,
        );
      case onboarding24Task:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding24Task.location, extra: extra);
      case onboarding25Wishlist:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding25Wishlist.location, extra: extra);
      case onboarding26Commitment:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding26Commitment.location, extra: extra);
      case onboarding27Notification:
        return GoRouter.of(context).pushReplacement<T>(
          onboarding27Notification.location,
          extra: extra,
        );
      case onboarding28Promise:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding28Promise.location, extra: extra);
      case onboarding29Chat:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding29Chat.location, extra: extra);
      case onboarding30Paywall:
        return GoRouter.of(context)
            .pushReplacement<T>(onboarding30Paywall.location, extra: extra);
    }
  }

  Future<T?> replace<T extends Object?>(
    final BuildContext context, {
    final Object? extra,
  }) {
    switch (this) {
      case authorization01Prompt:
        return GoRouter.of(context)
            .replace<T>(authorization01Prompt.location, extra: extra);
      case authorization02Verification:
        return GoRouter.of(context)
            .replace<T>(authorization02Verification.location, extra: extra);
      case onboarding00Splash:
        return GoRouter.of(context)
            .replace<T>(onboarding00Splash.location, extra: extra);
      case onboarding01Welcome:
        return GoRouter.of(context)
            .replace<T>(onboarding01Welcome.location, extra: extra);
      case onboarding02Introduction:
        return GoRouter.of(context)
            .replace<T>(onboarding02Introduction.location, extra: extra);
      case onboarding03Greeting:
        return GoRouter.of(context)
            .replace<T>(onboarding03Greeting.location, extra: extra);
      case onboarding04Gender:
        return GoRouter.of(context)
            .replace<T>(onboarding04Gender.location, extra: extra);
      case onboarding05Age:
        return GoRouter.of(context)
            .replace<T>(onboarding05Age.location, extra: extra);
      case onboarding06Info:
        return GoRouter.of(context)
            .replace<T>(onboarding06Info.location, extra: extra);
      case onboarding07MotivationQ1:
        return GoRouter.of(context)
            .replace<T>(onboarding07MotivationQ1.location, extra: extra);
      case onboarding08MotivationQ2:
        return GoRouter.of(context)
            .replace<T>(onboarding08MotivationQ2.location, extra: extra);
      case onboarding09MotivationQ3:
        return GoRouter.of(context)
            .replace<T>(onboarding09MotivationQ3.location, extra: extra);
      case onboarding10MotivationLevel:
        return GoRouter.of(context)
            .replace<T>(onboarding10MotivationLevel.location, extra: extra);
      case onboarding11Progress:
        return GoRouter.of(context)
            .replace<T>(onboarding11Progress.location, extra: extra);
      case onboarding12MentalHealthQ1:
        return GoRouter.of(context)
            .replace<T>(onboarding12MentalHealthQ1.location, extra: extra);
      case onboarding13MentalHealthQ2:
        return GoRouter.of(context)
            .replace<T>(onboarding13MentalHealthQ2.location, extra: extra);
      case onboarding14MentalHealthQ3:
        return GoRouter.of(context)
            .replace<T>(onboarding14MentalHealthQ3.location, extra: extra);
      case onboarding15MentalHealthQ4:
        return GoRouter.of(context)
            .replace<T>(onboarding15MentalHealthQ4.location, extra: extra);
      case onboarding16MentalHealthQ5:
        return GoRouter.of(context)
            .replace<T>(onboarding16MentalHealthQ5.location, extra: extra);
      case onboarding17Info2:
        return GoRouter.of(context)
            .replace<T>(onboarding17Info2.location, extra: extra);
      case onboarding18Comparison:
        return GoRouter.of(context)
            .replace<T>(onboarding18Comparison.location, extra: extra);
      case onboarding19Journey:
        return GoRouter.of(context)
            .replace<T>(onboarding19Journey.location, extra: extra);
      case onboarding20StatementQ1:
        return GoRouter.of(context)
            .replace<T>(onboarding20StatementQ1.location, extra: extra);
      case onboarding21StatementQ2:
        return GoRouter.of(context)
            .replace<T>(onboarding21StatementQ2.location, extra: extra);
      case onboarding22MotivationProgress:
        return GoRouter.of(context)
            .replace<T>(onboarding22MotivationProgress.location, extra: extra);
      case onboarding23Testimonials:
        return GoRouter.of(context)
            .replace<T>(onboarding23Testimonials.location, extra: extra);
      case onboarding24Task:
        return GoRouter.of(context)
            .replace<T>(onboarding24Task.location, extra: extra);
      case onboarding25Wishlist:
        return GoRouter.of(context)
            .replace<T>(onboarding25Wishlist.location, extra: extra);
      case onboarding26Commitment:
        return GoRouter.of(context)
            .replace<T>(onboarding26Commitment.location, extra: extra);
      case onboarding27Notification:
        return GoRouter.of(context)
            .replace<T>(onboarding27Notification.location, extra: extra);
      case onboarding28Promise:
        return GoRouter.of(context)
            .replace<T>(onboarding28Promise.location, extra: extra);
      case onboarding29Chat:
        return GoRouter.of(context)
            .replace<T>(onboarding29Chat.location, extra: extra);
      case onboarding30Paywall:
        return GoRouter.of(context)
            .replace<T>(onboarding30Paywall.location, extra: extra);
    }
  }
}

/// The wrapper around [MaterialApp] to support hot reload.
@immutable
class RoutesApp extends HookConsumerWidget {
  /// The wrapper around [MaterialApp] to support hot reload.
  const RoutesApp(this.initialRoute, {this.initialExtra, super.key});

  /// The current app's route.
  final Routes<RouteData> initialRoute;

  /// The current app's route extra.
  final Object? initialExtra;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    const ColorScheme colorScheme = ColorScheme.light(
      primary: Color(0xFF104b8e), // Main Blue
      secondary: Color(0xFFf2c265), // Main Yellow
      error: Color(0xFFf44242), // Red
      primaryContainer: Color(0xFF084080), // Dark Blue
      secondaryContainer: Color(0xFF528ccd), // Second Blue
      onSurface: Colors.white,
    );
    return MaterialApp.router(
      title: 'Dream Dash',
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: GoRouter(
        initialLocation: initialRoute.location,
        initialExtra: initialExtra,
        navigatorKey: initialRoute.navigatorKey,
        routes: <RouteBase>[
          $authorization01PromptRoute,
          $authorization02VerificationRoute,
          $onboarding00SplashRoute,
          $onboarding01WelcomeRoute,
          $onboarding02IntroductionRoute,
          $onboarding03GreetingRoute,
          $onboarding04GenderRoute,
          $onboarding05AgeRoute,
          $onboarding06InfoRoute,
          $onboarding07MotivationQ1Route,
          $onboarding08MotivationQ2Route,
          $onboarding09MotivationQ3Route,
          $onboarding10MotivationLevelRoute,
          $onboarding11ProgressRoute,
          $onboarding12MentalHealthQ1Route,
          $onboarding13MentalHealthQ2Route,
          $onboarding14MentalHealthQ3Route,
          $onboarding15MentalHealthQ4Route,
          $onboarding16MentalHealthQ5Route,
          $onboarding17Info2Route,
          $onboarding18ComparisonRoute,
          $onboarding19JourneyRoute,
          $onboarding20StatementQ1Route,
          $onboarding21StatementQ2Route,
          $onboarding22MotivationProgressRoute,
          $onboarding23TestimonialsRoute,
          $onboarding24TaskRoute,
          $onboarding25WishlistRoute,
          $onboarding26CommitmentRoute,
          $onboarding27NotificationRoute,
          $onboarding28PromiseRoute,
          $onboarding29ChatRoute,
          $onboarding30PaywallRoute,
        ],
      ),
      theme: ThemeData.from(
        colorScheme: colorScheme,
        textTheme: const TextTheme(
          /// .Numbers: For large numerical values, bold and prominent.
          displayLarge: TextStyle(
            fontFamily: 'Gotham Pro',
            fontSize: 40,
            fontWeight: FontWeight.w900,
            height: 1, // Line height for Numbers
          ),

          /// .Large-Gotham: For large headings, bolded.
          displayMedium: TextStyle(
            fontFamily: 'Gotham Pro',
            fontSize: 35,
            fontWeight: FontWeight.w700, // Bold
            height: 1, // Line height for Large-Gotham
          ),

          /// .Title: Main title style for significant headings.
          headlineLarge: TextStyle(
            fontFamily: 'Gotham Pro',
            fontSize: 28,
            fontWeight: FontWeight.w700, // Bold
            height: 1.29, // Line height for Title
          ),

          /// .Main-Heavy: For main content, heavy emphasis.
          titleLarge: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 24,
            fontWeight: FontWeight.w900, // Heavy
            height: 1.17, // Line height for Main-Heavy
          ),

          /// .Main-Semibold: For emphasized sections within content.
          titleMedium: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 24,
            fontWeight: FontWeight.w600, // Semibold
            height: 1.33, // Line height for Main-Semibold
          ),
          // .Mid-heavy: For mid-weight headings, bold style.
          titleSmall: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 22,
            fontWeight: FontWeight.w900, // Bold
            height: 1.45, // Line height for Mid-heavy
            letterSpacing: -0.22, // Adjusted letter spacing
          ),

          /// .Mid: Regular mid-weight content style.
          bodyLarge: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 22,
            fontWeight: FontWeight.w600, // Bold
            height: 1.45, // Line height for Mid-heavy
            letterSpacing: -0.22, // Adjusted letter spacing
          ),

          /// .Medium: For medium-sized text, semibold.
          bodyMedium: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 16,
            fontWeight: FontWeight.w600, // Semibold
            height: 1.38, // Line height for Medium
            letterSpacing: -0.41, // Adjusted letter spacing
          ),

          /// .Small-Medium: For small-sized, medium-weight text.
          /// .Small-Heavy: For small, bold text.
          bodySmall: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 12,
            fontWeight: FontWeight.w500, // Medium
            height: 1.33, // Line height for Small-Medium
            letterSpacing: -0.41, // Adjusted letter spacing
          ),

          /// .Botton-Bold: For bold buttons or prominent text.
          labelLarge: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 18,
            fontWeight: FontWeight.w700, // Bold
            height: 1, // Line height for Botton-Bold
            letterSpacing: -0.41, // Adjusted letter spacing
          ),

          /// .Botton-Regular: Regular button text style.
          labelMedium: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 18,
            fontWeight: FontWeight.normal, // Normal
            height: 1.33, // Line height for Botton-Regular
          ),

          /// .Small-Under: For small text with medium weight.
          labelSmall: TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 12,
            fontWeight: FontWeight.w500, // Medium
            height: 1, // Line height for Small-Under
            letterSpacing: -0.22, // Adjusted letter spacing
            decoration: TextDecoration.underline,
          ),
        ),
      ).copyWith(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: colorScheme.onSurface.withValues(alpha: 0.3),
          selectionHandleColor: colorScheme.onSurface.withValues(alpha: 0.3),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        menuButtonTheme: MenuButtonThemeData(
          style: SubmenuButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          filled: true,
          fillColor: colorScheme.primaryContainer,
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
      builder: (final BuildContext context, final Widget? child) {
        final ThemeData theme = Theme.of(context);
        final MediaQueryData mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
          child: DefaultTextStyle(
            style: theme.textTheme.titleMedium ?? const TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
              ),
              child: ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: Material(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(gradient: primaryGradient),
                    child: SafeArea(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: mediaQuery.size.width -
                              mediaQuery.padding.horizontal,
                          height: mediaQuery.size.height -
                              mediaQuery.padding.vertical,
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(EnumProperty<Routes<RouteData>>('initialRoute', initialRoute))
          ..add(DiagnosticsProperty<Object?>('initialExtra', initialExtra)),
      );
}
