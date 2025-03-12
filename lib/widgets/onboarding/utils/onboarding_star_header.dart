import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../../utils.dart';

class OnboardingStarHeader extends StatelessWidget {
  const OnboardingStarHeader({this.height = 158, super.key});

  final double height;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final $SourceAssetsOnboarding12MentalHealthQ1Gen assets =
        Assets.source.assets.onboarding.a12MentalHealthQ1;
    return Container(
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
      padding: EdgeInsets.only(
        top: mediaQuery.viewPadding.top + mediaQuery.viewInsets.top,
      ),
      child: SizedBox(
        width: mediaQuery.size.width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0 / 393 * mediaQuery.size.width,
              child: SizedBox(
                height: 137,
                child: assets.vector1.svg(
                  width: mediaQuery.size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 57,
              left: 238 / 393 * mediaQuery.size.width,
              child: assets.star34.svg(),
            ),
            Positioned(
              top: 99,
              left: 180 / 393 * mediaQuery.size.width,
              child: assets.star34.svg(),
            ),
            Positioned(
              top: 60,
              left: 78 / 393 * mediaQuery.size.width,
              child: assets.star32.svg(),
            ),
            Positioned(
              top: 114,
              left: 357 / 393 * mediaQuery.size.width,
              child: assets.star32.svg(),
            ),
            Positioned(
              left: 127 / 393 * mediaQuery.size.width,
              top: 28,
              child: Container(
                width: 35.03,
                height: 34,
                decoration: ShapeDecoration(
                  color: theme.colorScheme.secondary,
                  shape: const StarBorder(innerRadiusRatio: 0.01),
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
              left: 78 / 393 * mediaQuery.size.width,
              top: 95,
              child: Container(
                width: 29,
                height: 28.15,
                decoration: ShapeDecoration(
                  color: theme.colorScheme.secondary,
                  shape: const StarBorder(innerRadiusRatio: 0.01),
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
              left: 236 / 393 * mediaQuery.size.width,
              top: 117,
              child: Container(
                width: 42,
                height: 40.76,
                decoration: ShapeDecoration(
                  color: theme.colorScheme.secondary,
                  shape: const StarBorder(innerRadiusRatio: 0.01),
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
              left: 316 / 393 * mediaQuery.size.width,
              top: 45,
              child: Container(
                width: 35.03,
                height: 34,
                decoration: ShapeDecoration(
                  color: theme.colorScheme.secondary,
                  shape: const StarBorder(innerRadiusRatio: 0.01),
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
              left: 28 / 393 * mediaQuery.size.width,
              top: 52,
              child: Container(
                width: 23,
                height: 22,
                decoration: ShapeDecoration(
                  color: theme.colorScheme.secondary,
                  shape: const StarBorder(innerRadiusRatio: 0.01),
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
              left: 184 / 393 * mediaQuery.size.width,
              top: 52,
              child: Container(
                width: 6,
                height: 5.14,
                decoration: const ShapeDecoration(
                  gradient: secondaryGradient,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 306 / 393 * mediaQuery.size.width,
              top: 94,
              child: Container(
                width: 6,
                height: 5.14,
                decoration: const ShapeDecoration(
                  gradient: secondaryGradient,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 130 / 393 * mediaQuery.size.width,
              top: 88,
              child: Container(
                width: 6,
                height: 5.14,
                decoration: const ShapeDecoration(
                  gradient: secondaryGradient,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 22 / 393 * mediaQuery.size.width,
              top: 107,
              child: Container(
                width: 3,
                height: 3,
                decoration: const ShapeDecoration(
                  gradient: secondaryGradient,
                  shape: OvalBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties..add(DoubleProperty('height', height)),
      );
}
