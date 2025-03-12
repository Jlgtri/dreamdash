/*
 * Copyright (c) 2022 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'dart:async';
import 'dart:io' show File, Platform;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chatview/chatview.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Debouncer {
  Debouncer(this.duration);
  Timer? _debounce;
  Duration duration;

  void run(
    final VoidCallback callbackAfterTimeLapsed,
    final VoidCallback callbackBeforeTimeLapsed,
  ) {
    if (_debounce?.isActive ?? false) {
      callbackBeforeTimeLapsed();
      _debounce?.cancel();
    }
    _debounce = Timer(duration, callbackAfterTimeLapsed);
  }

  void dispose() {
    _debounce?.cancel();
  }
}

class PackageStrings {
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String repliedToYou = 'Replied to you';
  static const String repliedBy = 'Replied by';
  static const String more = 'More';
  static const String unsend = 'Unsend';
  static const String reply = 'Reply';
  static const String replyTo = 'Replying to';
  static const String message = 'Message';
  static const String reactionPopupTitle =
      'Tap and hold to multiply your reaction';
  static const String photo = 'Photo';
  static const String send = 'Send';
  static const String you = 'You';
  static const String report = 'Report';
}

class ChatUITextField extends StatefulWidget {
  const ChatUITextField({
    required this.focusNode,
    required this.textEditingController,
    required this.onPressed,
    required this.onRecordingComplete,
    required this.onImageSelected,
    super.key,
    this.sendMessageConfig,
  });

  /// Provides configuration of default text field in chat.
  final SendMessageConfiguration? sendMessageConfig;

  /// Provides focusNode for focusing text field.
  final FocusNode focusNode;

  /// Provides functions which handles text field.
  final TextEditingController textEditingController;

  /// Provides callback when user tap on text field.
  final VoidCallBack onPressed;

  /// Provides callback once voice is recorded.
  final void Function(String?) onRecordingComplete;

  /// Provides callback when user select images from camera/gallery.
  final StringsCallBack onImageSelected;

  @override
  State<ChatUITextField> createState() => _ChatUITextFieldState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(
          DiagnosticsProperty<SendMessageConfiguration?>(
            'sendMessageConfig',
            sendMessageConfig,
          ),
        )
        ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode))
        ..add(
          DiagnosticsProperty<TextEditingController>(
            'textEditingController',
            textEditingController,
          ),
        )
        ..add(DiagnosticsProperty<VoidCallBack>('onPressed', onPressed))
        ..add(
          ObjectFlagProperty<void Function(String? p1)>.has(
            'onRecordingComplete',
            onRecordingComplete,
          ),
        )
        ..add(
          DiagnosticsProperty<StringsCallBack>(
            'onImageSelected',
            onImageSelected,
          ),
        ),
    );
  }
}

class _ChatUITextFieldState extends State<ChatUITextField> {
  final ValueNotifier<String> _inputText = ValueNotifier('');

  final ImagePicker _imagePicker = ImagePicker();

  RecorderController? controller;

  ValueNotifier<bool> isRecording = ValueNotifier(false);

  SendMessageConfiguration? get sendMessageConfig => widget.sendMessageConfig;

  VoiceRecordingConfiguration? get voiceRecordingConfig =>
      widget.sendMessageConfig?.voiceRecordingConfiguration;

  ImagePickerIconsConfiguration? get imagePickerIconsConfig =>
      sendMessageConfig?.imagePickerIconsConfig;

  TextFieldConfiguration? get textFieldConfig =>
      sendMessageConfig?.textFieldConfig;

  CancelRecordConfiguration? get cancelRecordConfiguration =>
      sendMessageConfig?.cancelRecordConfiguration;

  OutlineInputBorder get _outLineBorder => OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius:
        widget.sendMessageConfig?.textFieldConfig?.borderRadius ??
        BorderRadius.circular(textFieldBorderRadius),
  );

  ValueNotifier<TypeWriterStatus> composingStatus =
      ValueNotifier<TypeWriterStatus>(TypeWriterStatus.typed);

  late Debouncer debouncer;

  @override
  void initState() {
    attachListeners();
    debouncer = Debouncer(
      sendMessageConfig?.textFieldConfig?.compositionThresholdTime ??
          const Duration(seconds: 1),
    );
    super.initState();

    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      controller = RecorderController();
    }
  }

  @override
  void dispose() {
    debouncer.dispose();
    composingStatus.dispose();
    isRecording.dispose();
    _inputText.dispose();
    super.dispose();
  }

  void attachListeners() {
    composingStatus.addListener(() {
      widget.sendMessageConfig?.textFieldConfig?.onMessageTyping?.call(
        composingStatus.value,
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    final OutlineInputBorder outlineBorder = _outLineBorder;
    return Container(
      padding:
          textFieldConfig?.padding ??
          const EdgeInsets.symmetric(horizontal: 6),
      margin: textFieldConfig?.margin,
      decoration: BoxDecoration(
        borderRadius:
            textFieldConfig?.borderRadius ??
            BorderRadius.circular(textFieldBorderRadius),
        color: sendMessageConfig?.textFieldBackgroundColor ?? Colors.white,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isRecording,
        builder:
            (final _, final bool isRecordingValue, final Widget? child) => Row(
              children: <Widget>[
                if (isRecordingValue && controller != null && !kIsWeb)
                  Expanded(
                    child: AudioWaveforms(
                      size: const Size(double.maxFinite, 50),
                      recorderController: controller!,
                      margin: voiceRecordingConfig?.margin,
                      padding:
                          voiceRecordingConfig?.padding ??
                          EdgeInsets.symmetric(
                            horizontal:
                                cancelRecordConfiguration == null ? 8 : 5,
                          ),
                      decoration:
                          voiceRecordingConfig?.decoration ??
                          BoxDecoration(
                            color: voiceRecordingConfig?.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                      waveStyle:
                          voiceRecordingConfig?.waveStyle ??
                          WaveStyle(
                            extendWaveform: true,
                            showMiddleLine: false,
                            waveColor:
                                voiceRecordingConfig?.waveStyle?.waveColor ??
                                Colors.black,
                          ),
                    ),
                  )
                else
                  Expanded(
                    child: TextField(
                      focusNode: widget.focusNode,
                      controller: widget.textEditingController,
                      style:
                          textFieldConfig?.textStyle ??
                          const TextStyle(color: Colors.white),
                      maxLines: textFieldConfig?.maxLines ?? 5,
                      minLines: textFieldConfig?.minLines ?? 1,
                      keyboardType: textFieldConfig?.textInputType,
                      inputFormatters: textFieldConfig?.inputFormatters,
                      onChanged: _onChanged,
                      enabled: textFieldConfig?.enabled,
                      textCapitalization:
                          textFieldConfig?.textCapitalization ??
                          TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText:
                            textFieldConfig?.hintText ??
                            PackageStrings.message,
                        fillColor:
                            sendMessageConfig?.textFieldBackgroundColor ??
                            Colors.white,
                        filled: true,
                        hintStyle:
                            textFieldConfig?.hintStyle ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              letterSpacing: 0.25,
                            ),
                        contentPadding:
                            textFieldConfig?.contentPadding ??
                            const EdgeInsets.symmetric(horizontal: 6),
                        border: outlineBorder,
                        focusedBorder: outlineBorder,
                        enabledBorder: outlineBorder,
                        disabledBorder: outlineBorder,
                      ),
                    ),
                  ),
                ValueListenableBuilder<String>(
                  valueListenable: _inputText,
                  builder: (
                    final _,
                    final String inputTextValue,
                    final Widget? child,
                  ) {
                    if (inputTextValue.isNotEmpty) {
                      return IconButton(
                        color:
                            sendMessageConfig?.defaultSendButtonColor ??
                            Colors.green,
                        onPressed:
                            (textFieldConfig?.enabled ?? true)
                                ? () {
                                  widget.onPressed();
                                  _inputText.value = '';
                                }
                                : null,
                        icon:
                            sendMessageConfig?.sendButtonIcon ??
                            const Icon(Icons.send),
                      );
                    } else {
                      return Row(
                        children: <Widget>[
                          if (!isRecordingValue) ...<Widget>[
                            if (sendMessageConfig?.enableCameraImagePicker ??
                                true)
                              IconButton(
                                constraints: const BoxConstraints(),
                                onPressed:
                                    (textFieldConfig?.enabled ?? true)
                                        ? () async => _onIconPressed(
                                          ImageSource.camera,
                                          config:
                                              sendMessageConfig
                                                  ?.imagePickerConfiguration,
                                        )
                                        : null,
                                icon:
                                    imagePickerIconsConfig
                                        ?.cameraImagePickerIcon ??
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color:
                                          imagePickerIconsConfig
                                              ?.cameraIconColor,
                                    ),
                              ),
                            if (sendMessageConfig?.enableGalleryImagePicker ??
                                true)
                              IconButton(
                                constraints: const BoxConstraints(),
                                onPressed:
                                    (textFieldConfig?.enabled ?? true)
                                        ? () async => _onIconPressed(
                                          ImageSource.gallery,
                                          config:
                                              sendMessageConfig
                                                  ?.imagePickerConfiguration,
                                        )
                                        : null,
                                icon:
                                    imagePickerIconsConfig
                                        ?.galleryImagePickerIcon ??
                                    Icon(
                                      Icons.image,
                                      color:
                                          imagePickerIconsConfig
                                              ?.galleryIconColor,
                                    ),
                              ),
                          ],
                          if ((sendMessageConfig?.allowRecordingVoice ??
                                  false) &&
                              !kIsWeb &&
                              (Platform.isIOS || Platform.isAndroid))
                            IconButton(
                              onPressed:
                                  (textFieldConfig?.enabled ?? true)
                                      ? _recordOrStop
                                      : null,
                              icon:
                                  (isRecordingValue
                                      ? voiceRecordingConfig?.stopIcon
                                      : voiceRecordingConfig?.micIcon) ??
                                  Icon(
                                    isRecordingValue ? Icons.stop : Icons.mic,
                                    color:
                                        voiceRecordingConfig
                                            ?.recorderIconColor,
                                  ),
                            ),
                          if (isRecordingValue &&
                              cancelRecordConfiguration != null)
                            IconButton(
                              onPressed: () async {
                                cancelRecordConfiguration?.onCancel?.call();
                                await _cancelRecording();
                              },
                              icon:
                                  cancelRecordConfiguration?.icon ??
                                  const Icon(Icons.cancel_outlined),
                              color:
                                  cancelRecordConfiguration?.iconColor ??
                                  voiceRecordingConfig?.recorderIconColor,
                            ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
      ),
    );
  }

  FutureOr<void> _cancelRecording() async {
    assert(
      defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android,
      'Voice messages are only supported with android and ios platform',
    );
    if (!isRecording.value) {
      return;
    }
    final String? path = await controller?.stop();
    if (path == null) {
      isRecording.value = false;
      return;
    }
    final File file = File(path);

    if (file.existsSync()) {
      await file.delete();
    }

    isRecording.value = false;
  }

  Future<void> _recordOrStop() async {
    assert(
      defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android,
      'Voice messages are only supported with android and ios platform',
    );
    if (!isRecording.value) {
      await controller?.record(
        sampleRate: voiceRecordingConfig?.sampleRate,
        bitRate: voiceRecordingConfig?.bitRate,
        androidEncoder: voiceRecordingConfig?.androidEncoder,
        iosEncoder: voiceRecordingConfig?.iosEncoder,
        androidOutputFormat: voiceRecordingConfig?.androidOutputFormat,
      );
      isRecording.value = true;
    } else {
      final String? path = await controller?.stop();
      isRecording.value = false;
      widget.onRecordingComplete(path);
    }
  }

  Future<void> _onIconPressed(
    final ImageSource imageSource, {
    final ImagePickerConfiguration? config,
  }) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: imageSource,
        maxHeight: config?.maxHeight,
        maxWidth: config?.maxWidth,
        imageQuality: config?.imageQuality,
        preferredCameraDevice:
            config?.preferredCameraDevice ?? CameraDevice.rear,
      );
      String? imagePath = image?.path;
      if (config?.onImagePicked != null) {
        final String? updatedImagePath = await config?.onImagePicked!(
          imagePath,
        );
        if (updatedImagePath != null) imagePath = updatedImagePath;
      }
      widget.onImageSelected(imagePath ?? '', '');
    } catch (e) {
      widget.onImageSelected('', e.toString());
    }
  }

  void _onChanged(final String inputText) {
    debouncer.run(
      () {
        composingStatus.value = TypeWriterStatus.typed;
      },
      () {
        composingStatus.value = TypeWriterStatus.typing;
      },
    );
    _inputText.value = inputText;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(
          DiagnosticsProperty<RecorderController?>('controller', controller),
        )
        ..add(
          DiagnosticsProperty<ValueNotifier<bool>>('isRecording', isRecording),
        )
        ..add(
          DiagnosticsProperty<SendMessageConfiguration?>(
            'sendMessageConfig',
            sendMessageConfig,
          ),
        )
        ..add(
          DiagnosticsProperty<VoiceRecordingConfiguration?>(
            'voiceRecordingConfig',
            voiceRecordingConfig,
          ),
        )
        ..add(
          DiagnosticsProperty<ImagePickerIconsConfiguration?>(
            'imagePickerIconsConfig',
            imagePickerIconsConfig,
          ),
        )
        ..add(
          DiagnosticsProperty<TextFieldConfiguration?>(
            'textFieldConfig',
            textFieldConfig,
          ),
        )
        ..add(
          DiagnosticsProperty<CancelRecordConfiguration?>(
            'cancelRecordConfiguration',
            cancelRecordConfiguration,
          ),
        )
        ..add(
          DiagnosticsProperty<ValueNotifier<dynamic>>(
            'composingStatus',
            composingStatus,
          ),
        )
        ..add(DiagnosticsProperty<Debouncer>('debouncer', debouncer)),
    );
  }
}
