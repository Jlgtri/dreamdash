import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates [ChatController] that will be disposed automatically.
///
/// See also:
/// - [ChatController]
ChatController useChatController({
  required final List<Message> initialMessageList,
  required final ScrollController scrollController,
  required final List<ChatUser> otherUsers,
  required final ChatUser currentUser,
  final List<Object?>? keys,
}) => use(
  _ChatControllerHook(
    initialMessageList: initialMessageList,
    scrollController: scrollController,
    otherUsers: otherUsers,
    currentUser: currentUser,
    keys: keys,
  ),
);

class _ChatControllerHook extends Hook<ChatController> {
  const _ChatControllerHook({
    required this.initialMessageList,
    required this.scrollController,
    required this.otherUsers,
    required this.currentUser,
    super.keys,
  });

  final List<Message> initialMessageList;
  final ScrollController scrollController;
  final List<ChatUser> otherUsers;
  final ChatUser currentUser;

  @override
  HookState<ChatController, Hook<ChatController>> createState() =>
      _ChatControllerHookState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            IterableProperty<Message>(
              'initialMessageList',
              initialMessageList,
            ),
          )
          ..add(
            DiagnosticsProperty<ScrollController>(
              'scrollController',
              scrollController,
            ),
          )
          ..add(IterableProperty<ChatUser>('otherUsers', otherUsers))
          ..add(DiagnosticsProperty<ChatUser>('currentUser', currentUser)),
      );
}

class _ChatControllerHookState
    extends HookState<ChatController, _ChatControllerHook> {
  late final ChatController controller = ChatController(
    initialMessageList: hook.initialMessageList,
    scrollController: hook.scrollController,
    otherUsers: hook.otherUsers,
    currentUser: hook.currentUser,
  );

  @override
  ChatController build(final BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useChatController';

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(DiagnosticsProperty<ChatController>('controller', controller)),
      );
}
