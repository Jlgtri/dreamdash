import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/i18n.g.dart';

/// The welcome screen of the onboarding flow.
@TypedGoRoute<Onboarding01WelcomeRoute>(path: '/onboarding/01_welcome')
class Onboarding01WelcomeRoute extends GoRouteData {
  /// The welcome screen of the onboarding flow.
  const Onboarding01WelcomeRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding01WelcomeScreen();

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
            RotationTransition(turns: animation, child: child),
      );
}

/// The welcome screen of the onboarding flow.
class Onboarding01WelcomeScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding01WelcomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final I18N i18n = I18N.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.22850939631462097, 0.510448694229126),
          end: Alignment(-0.39639779925346375, 0.38534778356552124),
          colors: <Color>[
            Color.fromRGBO(16, 75, 142, 1),
            Color.fromRGBO(82, 139, 204, 1),
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 561,
            left: 24,
            child: Container(
              decoration: const BoxDecoration(),
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(),
                    padding: EdgeInsets.zero,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          i18n.onboarding01WelcomeScreenWelcome,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Gotham Pro',
                            fontSize: 35,
                            letterSpacing: -0.22221098840236664,
                            fontWeight: FontWeight.normal,
                            height: 1.1428571428571428,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          i18n.onboarding01WelcomeScreenToYourDreamS,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: undefined,
                            fontFamily: 'SF Pro Text',
                            fontSize: 22,
                            letterSpacing: -0.22221098840236664,
                            fontWeight: FontWeight.normal,
                            height: 1.4545454545454546,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 19),
                  const SizedBox(height: 19),
                  const SizedBox(height: 19),
                  Text(
                    'By continuing you agree with our privacy policy and terms of use',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      letterSpacing: -0.22221098840236664,
                      fontWeight: FontWeight.normal,
                      height: 0.9984970887502035,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 47,
            left: 0,
            child: Container(
              width: 393,
              height: 494,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Picture11.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
