s = [
    "onboarding_03_greeting_screen.dart",
    "onboarding_04_gender_screen.dart",
    "onboarding_05_age_screen.dart",
    "onboarding_06_info_screen.dart",
    "onboarding_07_motivation_q1_screen.dart",
    "onboarding_08_motivation_q2_screen.dart",
    "onboarding_09_motivation_q3_screen.dart",
    "onboarding_10_motivation_level_screen.dart",
    "onboarding_11_progress_screen.dart",
    "onboarding_12_mental_health_q1_screen.dart",
    "onboarding_13_mental_health_q2_screen.dart",
    "onboarding_14_mental_health_q3_screen.dart",
    "onboarding_15_mental_health_q4_screen.dart",
    "onboarding_16_mental_health_q5_screen.dart",
    "onboarding_17_info_2_screen.dart",
    "onboarding_18_comparison_screen.dart",
    "onboarding_19_journey_screen.dart",
    "onboarding_20_statement_q1_screen.dart",
    "onboarding_21_statement_q2_screen.dart",
    "onboarding_22_motivation_progress_screen.dart",
    "onboarding_23_testimonials_screen.dart",
    "onboarding_24_task_screen.dart",
    "onboarding_25_wishlist_screen.dart",
    "onboarding_26_commitment_screen.dart",
    "onboarding_27_notification_screen.dart",
    "onboarding_28_promise_screen.dart",
    "onboarding_29_chat_screen.dart",
    "onboarding_30_blur_screen.dart",
    "onboarding_31_paywall_screen.dart",
]
from pathlib import Path

# for _ in s:
#     name = "".join(
#         _.title() for _ in _.removesuffix("_screen.dart").split("_")
#     )
#     print(name[0].lower() + name[1:])
# exit()
for _ in s:
    name = "".join(
        _.title()
        for _ in _.removeprefix("onboarding_")
        .removesuffix("_screen.dart")
        .split("_")
    )
    Path("lib", "widgets", "onboarding", _).write_text(
        """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.gen.dart';
import '../../generated/i18n.g.dart';
import 'utils/onboarding_utils.dart';

part 'onboarding_{path}_screen.g.dart';

@TypedGoRoute<Onboarding{name}Route>(
  path: '/onboarding/{path}',
)
class Onboarding{name}Route extends GoRouteData {{
  const Onboarding{name}Route();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding{name}Screen();

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
}}

/// The welcome screen of the onboarding flow.
class Onboarding{name}Screen extends HookConsumerWidget {{
  /// The welcome screen of the onboarding flow.
  const Onboarding{name}Screen({{super.key}});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {{
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA{name}EnUs i18n =
        I18N.of(context).onboarding.a{name};
    final $SourceAssetsOnboarding{name}Gen assets =
        Assets.source.assets.onboarding.a{name};
    final ScrollController scrollController = useScrollController();

    useMemoized(() {{
      WidgetsBinding.instance.addPostFrameCallback(
        (final _) async => scrollController.scrollToBottom(),
      );
    }});
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              constraints: BoxConstraints(
                minHeight: mediaQuery.size.height,
                maxWidth: mediaQuery.size.width,
              ),
              padding: mediaQuery.padding + EdgeInsets.symmetric(horizontal: 24),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.40, -0.91),
                  end: Alignment(-0.4, 0.91),
                  colors: <Color>[Color(0xFF104B8E), Color(0xFF306AAC)],
                ),
              ),
              child: CustomScrollView(
                controller: scrollController,
                shrinkWrap: true,
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ),
        ),
      ),
    );
  }}
}}
""".format(
            name=name,
            path=_.removeprefix("onboarding_").removesuffix("_screen.dart"),
        )
    )
