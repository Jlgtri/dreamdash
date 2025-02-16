import 'dart:io';
import 'dart:ui';

import 'package:amplitude_flutter/events/base_event.dart';
import 'package:chatview/chatview.dart';

/// The same as following.
// ignore: document_ignores
// ignore: implementation_imports
import 'package:chatview/src/utils/constants/constants.dart';

/// Needed for accessing private widget. IDK why it wasnt exported by default.
// ignore: document_ignores
// ignore: implementation_imports
import 'package:chatview/src/widgets/chatui_textfield.dart';
import 'package:flutter/foundation.dart';
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
import 'utils/chat_controller_hook.dart';

part 'onboarding_29_chat_screen.g.dart';

@TypedGoRoute<Onboarding29ChatRoute>(
  path: '/onboarding/29_chat',
)
class Onboarding29ChatRoute extends GoRouteData {
  const Onboarding29ChatRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const Onboarding29ChatScreen();

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
class Onboarding29ChatScreen extends HookConsumerWidget {
  /// The welcome screen of the onboarding flow.
  const Onboarding29ChatScreen({super.key});
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    final I18NOnboardingA29ChatEnUs i18n = I18N.of(context).onboarding.a29Chat;
    final $SourceAssetsOnboarding29ChatGen assets =
        Assets.source.assets.onboarding.a29Chat;

    final ScrollController scrollController = useScrollController();
    final ObjectRef<int> messageId = useRef(1);
    final ChatController chatController = useChatController(
      initialMessageList: <Message>[
        Message(
          id: '0',
          message: '',
          sentBy: 'coach',
          createdAt: DateTime.now(),
          messageType: MessageType.custom,
          status: MessageStatus.delivered,
        ),
      ],
      scrollController: scrollController,
      currentUser: ChatUser(id: 'user', name: ref.read(nameProvider)),
      otherUsers: <ChatUser>[ChatUser(id: 'coach', name: 'DreamCoach')],
      keys: <Object?>[scrollController],
    );
    final FocusNode focusNode = useFocusNode();
    final TextEditingController textController = useTextEditingController();
    final ObjectRef<GlobalKey<State<StatefulWidget>>> chatTextFieldViewKey =
        useRef(GlobalKey());
    final ValueNotifier<bool> isLoading = useState(true);
    final ValueNotifier<bool> answerGiven = useState(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback((final _) async {
        await scrollController.scrollToBottom();
        chatController.setTypingIndicator = true;
        await Future<void>.delayed(const Duration(seconds: 1));
        chatController.setTypingIndicator = false;
        await Future<void>.delayed(const Duration(milliseconds: 150));
        final Message message = Message(
          id: '${messageId.value++}',
          message: i18n.focusQuestion,
          sentBy: 'coach',
          createdAt: DateTime.now(),
          status: MessageStatus.delivered,
        );
        chatController.addMessage(message);
        isLoading.value = false;
      });
    });

    Future<void> onMessageSent(
      final String messageText,
      final ReplyMessage replyMessage,
      final MessageType messageType,
    ) async {
      if (!isLoading.value) {
        try {
          isLoading.value = true;
          final Message message = Message(
            id: '${messageId.value++}',
            message: messageText,
            sentBy: 'user',
            createdAt: DateTime.now(),
            replyMessage: replyMessage,
            messageType: messageType,
            status: MessageStatus.delivered,
          );
          chatController.addMessage(message);
          await Future<void>.delayed(const Duration(seconds: 1));
          chatController.setTypingIndicator = true;
          await Future<void>.delayed(const Duration(seconds: 1));
          chatController.setTypingIndicator = false;
          await Future<void>.delayed(const Duration(milliseconds: 150));
          answerGiven.value = true;

          chatController.addMessage(
            Message(
              id: '${messageId.value++}',
              message: i18n.desireAdvice,
              sentBy: 'coach',
              createdAt: DateTime.now(),
              status: MessageStatus.delivered,
            ),
          );
          await Future<void>.delayed(const Duration(milliseconds: 250));
          chatController.setTypingIndicator = true;
          await Future<void>.delayed(const Duration(seconds: 1));
          chatController.setTypingIndicator = false;
          await Future<void>.delayed(const Duration(milliseconds: 150));
          chatController.addMessage(
            Message(
              id: '${messageId.value++}',
              message: i18n.skillsAdvice,
              sentBy: 'coach',
              createdAt: DateTime.now(),
              messageType: MessageType.custom,
              status: MessageStatus.delivered,
            ),
          );
        } finally {
          isLoading.value = false;
        }
      }
    }

    Future<void> next() async {
      if (!isLoading.value) {
        isLoading.value = true;
        try {
          await ref.read(analyticsProvider.notifier).track(
                BaseEvent(
                  'onboarding_screen_28_clicked',
                  eventProperties: <String, Object?>{
                    'ob_type': 'quiz_1',
                    'screen_type': 'dreamcoach',
                    'answer': 'continue',
                  },
                ),
              );
          final Routes<RouteData>? route =
              await ref.read(onboardingProvider.notifier).next();
          if (context.mounted) {
            await route?.pushReplacement(context);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    final SendMessageConfiguration sendMessageConfig = SendMessageConfiguration(
      textFieldBackgroundColor: theme.colorScheme.primary,
      enableCameraImagePicker: false,
      enableGalleryImagePicker: false,
      allowRecordingVoice: false,
      textFieldConfig: TextFieldConfiguration(
        enabled: !isLoading.value,
        textStyle: theme.textTheme.labelMedium,
        hintStyle: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(25),
        margin: const EdgeInsets.all(24),
        hintText: i18n.placeholder,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
      defaultSendButtonColor:
          theme.colorScheme.onSurface.withValues(alpha: 0.2),
      sendButtonIcon: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(5, 4),
              blurRadius: 4,
            ),
          ],
          color: Color.fromRGBO(82, 140, 205, 1),
          borderRadius: BorderRadius.all(Radius.elliptical(32, 32)),
        ),
        padding: const EdgeInsets.all(10),
        child: assets.vector.svg(),
      ),
    );
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          selectionColor: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          selectionHandleColor:
              theme.colorScheme.onSurface.withValues(alpha: 0.2),
        ),
      ),
      child: Container(
        padding: mediaQuery.viewPadding + mediaQuery.viewInsets,
        decoration: const BoxDecoration(gradient: primaryGradient),
        child: ChatView(
          chatController: chatController,
          onSendTap: onMessageSent,
          sendMessageConfig: sendMessageConfig,
          chatViewState: ChatViewState.hasMessages,
          chatBackgroundConfig: const ChatBackgroundConfiguration(
            backgroundColor: Colors.transparent,
            // height: mediaQuery.size.height - (273 + 24 + 12),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
          ),
          chatBubbleConfig: ChatBubbleConfiguration(
            maxWidth: mediaQuery.size.width * 0.8,
            padding: EdgeInsets.zero,
            outgoingChatBubbleConfig: ChatBubble(
              color: theme.colorScheme.primaryContainer,
              textStyle: theme.textTheme.labelMedium,
              padding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(15),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            inComingChatBubbleConfig: ChatBubble(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              textStyle: theme.textTheme.labelMedium,
              padding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(15),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          featureActiveConfig: FeatureActiveConfig(
            enableChatSeparator: false,
            enableDoubleTapToLike: false,
            enableOtherUserName: false,
            enableOtherUserProfileAvatar: false,
            enableReactionPopup: false,
            enableReplySnackBar: false,
            enableSwipeToReply: false,
            enableSwipeToSeeTime: false,
            enableTextField: !answerGiven.value,
            lastSeenAgoBuilderVisibility: false,
            receiptsBuilderVisibility: false,
          ),
          sendMessageBuilder: (final ReplyMessage? replyMessage) => SizedBox(
            width: mediaQuery.size.width,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                bottomPadding4,
                bottomPadding4,
                bottomPadding4,
                (!kIsWeb && Platform.isIOS)
                    ? (focusNode.hasFocus
                        ? bottomPadding1
                        : mediaQuery.viewPadding.bottom > 0
                            ? bottomPadding2
                            : bottomPadding3)
                    : bottomPadding3,
              ),
              child: ChatUITextField(
                key: chatTextFieldViewKey.value,
                focusNode: focusNode,
                textEditingController: textController,
                sendMessageConfig: sendMessageConfig,
                onPressed: () async {
                  final String messageText = textController.text.trim();
                  textController.clear();
                  if (messageText.isEmpty) {
                    return;
                  }
                  await onMessageSent(
                    messageText.trim(),
                    const ReplyMessage(),
                    MessageType.text,
                  );
                },
                onRecordingComplete: (final _) {},
                onImageSelected: (final _, final __) {},
              ),
            ),
          ),
          messageConfig: MessageConfiguration(
            customMessageBuilder: (final Message message) => message.id != '0'
                ? Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 4,
                          sigmaY: 4,
                          tileMode: TileMode.decal,
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: mediaQuery.size.width * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            message.message,
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromRGBO(
                                0,
                                0,
                                0,
                                0.1,
                              ),
                              offset: Offset(5, 4),
                              blurRadius: 4,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment(
                              0.5162850022315979,
                              1.1666361093521118,
                            ),
                            end: Alignment(
                              -0.9032666087150574,
                              0.8645972609519958,
                            ),
                            colors: <Color>[
                              Color.fromRGBO(16, 75, 142, 1),
                              Color.fromRGBO(48, 106, 172, 1),
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: next,
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            overlayColor: theme.colorScheme.onSurface
                                .withValues(alpha: 0.2),
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  width: 131,
                                  child: Text(
                                    i18n.buttonText,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                                const SizedBox(width: 36),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: assets.arrowRight.svg(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 12),
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
                                assets.star31.svg(),
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
                                      TextSpan(text: i18n.coach),
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
          ),
        ),
      ),
    );
  }
}
