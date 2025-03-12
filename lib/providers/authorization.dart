import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../env.dart';
import 'analytics.dart';

part 'authorization.g.dart';

/// The provider of the [Supabase] client.
@Riverpod(keepAlive: true)
Supabase _supabase(final Ref ref) => throw UnimplementedError();

/// Default override for [_supabaseProvider].
Future<Override> get $supabase async => _supabaseProvider.overrideWithValue(
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  ),
);

@Riverpod(keepAlive: true, dependencies: <Object>[_supabase])
class Authorization extends _$Authorization {
  SupabaseClient get _supabase => ref.read(_supabaseProvider).client;

  @override
  FutureOr<Session?> build() {
    ref.listenSelf((final _, final AsyncValue<Session?> next) async {
      if (next is AsyncData) {
        await ref
            .read(analyticsProvider.notifier)
            .setUserId(next.requireValue?.user.id);
      }
    });
    return _supabase.auth.currentSession;
  }

  Future<void> signInWithOtp(final String email) async =>
      _supabase.auth.signInWithOtp(email: email);

  Future<void> signInWithEmail(final String email, final String token) async {
    state = const AsyncValue<Session?>.loading();
    final AuthResponse response = await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.email,
    );
    state = AsyncValue<Session?>.data(response.session);
  }

  Future<AuthResponse> signInWithGoogle() async {
    // TODO(fdsdfsd): Update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const String webClientId = 'my-web.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const String iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final String? accessToken = googleAuth.accessToken;
    final String? idToken = googleAuth.idToken;
    if (accessToken == null || idToken == null) {
      throw Exception('No Access Token or ID Token found.');
    }
    return _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  /// Performs Apple sign in on iOS or macOS
  Future<AuthResponse> signInAnonymously() async =>
      _supabase.auth.signInAnonymously();

  /// Performs Apple sign in on iOS or macOS
  Future<AuthResponse> signInWithApple() async {
    final String rawNonce = _supabase.auth.generateRawNonce();
    final String hashedNonce =
        sha256.convert(utf8.encode(rawNonce)).toString();

    final AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
          scopes: <AppleIDAuthorizationScopes>[
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: hashedNonce,
        );

    final String? idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
        'Could not find ID Token from generated credential.',
      );
    }

    return _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }
}

@Riverpod(keepAlive: true)
class Email extends _$Email {
  @override
  String build() => '';

  @override
  String get state => super.state;

  @override
  set state(final String value) => super.state = value;
}
