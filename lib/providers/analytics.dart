import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:amplitude_flutter/events/event_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../env.dart';

part 'analytics.g.dart';

/// The provider of the [Amplitude] client.
@Riverpod(keepAlive: true)
Amplitude _amplitude(final Ref ref) => throw UnimplementedError();

/// Default override for [_amplitudeProvider].
Future<Override> get $amplitude async {
  // Create and initailize the instance
  final Amplitude amplitude = Amplitude(
    Configuration(apiKey: Env.amplitudeKey),
  );
  await amplitude.isBuilt;
  return _amplitudeProvider.overrideWithValue(amplitude);
}

@Riverpod(keepAlive: true, dependencies: <Object>[_amplitude])
class Analytics extends _$Analytics {
  Amplitude get _amplitude => ref.read(_amplitudeProvider);

  @override
  void build() {}

  Future<void> setUserId(final String? userId) => _amplitude.setUserId(userId);

  Future<void> track(
    final BaseEvent event, [
    final EventOptions? options,
  ]) =>
      _amplitude.track(event, options);
}
