import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../routes.dart';

part 'onboarding.g.dart';
part 'onboarding.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum Gender { female, male, nonBinary, other }

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum Age { a18_25, a26_35, a36_45, a46_55, a55_ }

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum Frequency { almostAlways, often, sometimes, never }

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum DailyGoal { min5, min10, min15, min20 }

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum PaywallPeriod { annually, monthly, weekly, none }

@MappableClass()
class OnboardingState with OnboardingStateMappable {
  const OnboardingState({
    this.a01Welcome = false,
    this.a02IntroductionName = '',
    this.a03Greeting = false,
    this.a04Gender,
    this.a05Age,
    this.a06Info = false,
    this.a07MotivationQ1Result,
    this.a08MotivationQ2Result,
    this.a09MotivationQ3Result,
    this.a10MotivationLevel = false,
    this.a11Progress = false,
    this.a12MentalHealthQ1Result,
    this.a13MentalHealthQ2Result,
    this.a14MentalHealthQ3Result,
    this.a15MentalHealthQ4Result,
    this.a16MentalHealthQ5Result,
    this.a17Info2 = false,
    this.a18Comparison = false,
    this.a19Journey = false,
    this.a20StatementQ1Result,
    this.a21StatementQ2Result,
    this.a22MotivationProgress = false,
    this.a23Testimonials = false,
    this.a24Task = false,
    this.a25Wishlist = const <String>[],
    this.a26Commitment,
    this.a27Notification,
    this.a28Promise = false,
    this.a29Chat = false,
    this.a30PaywallPeriod,
  });

  factory OnboardingState.debug() => const OnboardingState(
    a01Welcome: true,
    a02IntroductionName: 'test',
    a03Greeting: true,
    a04Gender: Gender.female,
    a05Age: Age.a18_25,
    a06Info: true,
    a07MotivationQ1Result: true,
    a08MotivationQ2Result: true,
    a09MotivationQ3Result: true,
    a10MotivationLevel: true,
    a11Progress: true,
    a12MentalHealthQ1Result: Frequency.almostAlways,
    a13MentalHealthQ2Result: Frequency.almostAlways,
    a14MentalHealthQ3Result: Frequency.almostAlways,
    a15MentalHealthQ4Result: Frequency.almostAlways,
    a16MentalHealthQ5Result: Frequency.almostAlways,
    a17Info2: true,
    a18Comparison: true,
    a19Journey: true,
    a20StatementQ1Result: true,
    a21StatementQ2Result: true,
    a22MotivationProgress: true,
    a23Testimonials: true,
    a24Task: true,
    a25Wishlist: <String>['test1', 'test2', 'test3'],
    a26Commitment: DailyGoal.min5,
    a27Notification: false,
    a28Promise: true,
    a29Chat: true,
  );

  final bool a01Welcome;
  final String a02IntroductionName;
  final bool a03Greeting;
  final Gender? a04Gender;
  final Age? a05Age;
  final bool a06Info;
  final bool? a07MotivationQ1Result;
  final bool? a08MotivationQ2Result;
  final bool? a09MotivationQ3Result;
  final bool a10MotivationLevel;
  final bool a11Progress;
  final Frequency? a12MentalHealthQ1Result;
  final Frequency? a13MentalHealthQ2Result;
  final Frequency? a14MentalHealthQ3Result;
  final Frequency? a15MentalHealthQ4Result;
  final Frequency? a16MentalHealthQ5Result;
  final bool a17Info2;
  final bool a18Comparison;
  final bool a19Journey;
  final bool? a20StatementQ1Result;
  final bool? a21StatementQ2Result;
  final bool a22MotivationProgress;
  final bool a23Testimonials;
  final bool a24Task;
  final List<String> a25Wishlist;
  final DailyGoal? a26Commitment;
  final bool? a27Notification;
  final bool a28Promise;
  final bool a29Chat;
  final PaywallPeriod? a30PaywallPeriod;

  Routes<RouteData>? get route {
    if (!a01Welcome) {
      return Routes.onboarding01Welcome;
    } else if (a02IntroductionName.isEmpty) {
      return Routes.onboarding02Introduction;
    } else if (!a03Greeting) {
      return Routes.onboarding03Greeting;
    } else if (a04Gender == null) {
      return Routes.onboarding04Gender;
    } else if (a05Age == null) {
      return Routes.onboarding05Age;
    } else if (!a06Info) {
      return Routes.onboarding06Info;
    } else if (a07MotivationQ1Result == null) {
      return Routes.onboarding07MotivationQ1;
    } else if (a08MotivationQ2Result == null) {
      return Routes.onboarding08MotivationQ2;
    } else if (a09MotivationQ3Result == null) {
      return Routes.onboarding09MotivationQ3;
    } else if (!a10MotivationLevel) {
      return Routes.onboarding10MotivationLevel;
    } else if (!a11Progress) {
      return Routes.onboarding11Progress;
    } else if (a12MentalHealthQ1Result == null) {
      return Routes.onboarding12MentalHealthQ1;
    } else if (a13MentalHealthQ2Result == null) {
      return Routes.onboarding13MentalHealthQ2;
    } else if (a14MentalHealthQ3Result == null) {
      return Routes.onboarding14MentalHealthQ3;
    } else if (a15MentalHealthQ4Result == null) {
      return Routes.onboarding15MentalHealthQ4;
    } else if (a16MentalHealthQ5Result == null) {
      return Routes.onboarding16MentalHealthQ5;
    } else if (!a17Info2) {
      return Routes.onboarding17Info2;
    } else if (!a18Comparison) {
      return Routes.onboarding18Comparison;
    } else if (!a19Journey) {
      return Routes.onboarding19Journey;
    } else if (a20StatementQ1Result == null) {
      return Routes.onboarding20StatementQ1;
    } else if (a21StatementQ2Result == null) {
      return Routes.onboarding21StatementQ2;
    } else if (!a22MotivationProgress) {
      return Routes.onboarding22MotivationProgress;
    } else if (!a23Testimonials) {
      return Routes.onboarding23Testimonials;
    } else if (!a24Task) {
      return Routes.onboarding24Task;
    } else if (a25Wishlist.length < 3) {
      return Routes.onboarding25Wishlist;
    } else if (a26Commitment == null) {
      return Routes.onboarding26Commitment;
    } else if (a27Notification == null && !kIsWeb) {
      return Routes.onboarding27Notification;
    } else if (!a28Promise) {
      return Routes.onboarding28Promise;
    } else if (!a29Chat) {
      return Routes.onboarding29Chat;
    } else if (a30PaywallPeriod == null) {
      return Routes.onboarding30Paywall;
    } else {
      return null;
    }
  }

  double? get motivationLevel {
    if (a07MotivationQ1Result == null ||
        a08MotivationQ2Result == null ||
        a09MotivationQ3Result == null) {
      return null;
    }
    final int motivated =
        (a07MotivationQ1Result! ? 1 : 0) +
        (a08MotivationQ2Result! ? 1 : 0) +
        (a09MotivationQ3Result! ? 1 : 0);
    switch (motivated) {
      case 1:
        return 0 / 67;
      case 2:
        return 0.54;
      case 3:
        return 0.2;
      default:
        return 0;
    }
  }
}

@Riverpod(keepAlive: true)
class Onboarding extends _$Onboarding {
  // Future<List<Todo>> _fetchTodo() async {
  //   final json = await http.get('api/todos');
  //   final List<Map<String, dynamic>> todos =
  //       jsonDecode(json) as List<Map<String, dynamic>>;
  //   return todos.map(Todo.fromJson).toList();
  // }

  @override
  FutureOr<OnboardingState> build() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _stopwatch.start();
    return const OnboardingState();
  }

  Future<void> _update(final OnboardingState onboarding) async {
    // Set the state to loading
    state = const AsyncValue<OnboardingState>.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      // await http.post('api/todos', todo.toJson());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return onboarding;
    });
  }

  final Stopwatch _stopwatch = Stopwatch();
  Stopwatch get stopwatch => _stopwatch;

  OnboardingState get _onboarding => state.requireValue;

  Future<Routes<RouteData>?> next() async {
    if (!_onboarding.a01Welcome) {
      await _update(_onboarding.copyWith(a01Welcome: true));
    } else if (_onboarding.a02IntroductionName.isEmpty) {
      throw Exception('Need to set name first.');
    } else if (!_onboarding.a03Greeting) {
      await _update(_onboarding.copyWith(a03Greeting: true));
    } else if (_onboarding.a04Gender == null) {
      throw Exception('Need to set gender first.');
    } else if (_onboarding.a05Age == null) {
      throw Exception('Need to set age first.');
    } else if (!_onboarding.a06Info) {
      await _update(_onboarding.copyWith(a06Info: true));
    } else if (_onboarding.a07MotivationQ1Result == null) {
      throw Exception('Need to set MotivationQ1Result first.');
    } else if (_onboarding.a08MotivationQ2Result == null) {
      throw Exception('Need to set MotivationQ2Result first.');
    } else if (_onboarding.a09MotivationQ3Result == null) {
      throw Exception('Need to set MotivationQ3Result first');
    } else if (!_onboarding.a10MotivationLevel) {
      await _update(_onboarding.copyWith(a10MotivationLevel: true));
    } else if (!_onboarding.a11Progress) {
      await _update(_onboarding.copyWith(a11Progress: true));
    } else if (_onboarding.a12MentalHealthQ1Result == null) {
      throw Exception('Need to set MentalHealthQ1Result first.');
    } else if (_onboarding.a13MentalHealthQ2Result == null) {
      throw Exception('Need to set MentalHealthQ2Result first.');
    } else if (_onboarding.a14MentalHealthQ3Result == null) {
      throw Exception('Need to set MentalHealthQ3Result first.');
    } else if (_onboarding.a15MentalHealthQ4Result == null) {
      throw Exception('Need to set MentalHealthQ4Result first.');
    } else if (_onboarding.a16MentalHealthQ5Result == null) {
      throw Exception('Need to set MentalHealthQ5Result first.');
    } else if (!_onboarding.a17Info2) {
      await _update(_onboarding.copyWith(a17Info2: true));
    } else if (!_onboarding.a18Comparison) {
      await _update(_onboarding.copyWith(a18Comparison: true));
    } else if (!_onboarding.a19Journey) {
      await _update(_onboarding.copyWith(a19Journey: true));
    } else if (_onboarding.a20StatementQ1Result == null) {
      throw Exception('Need to set StatementQ1Result first.');
    } else if (_onboarding.a21StatementQ2Result == null) {
      throw Exception('Need to set StatementQ2Result first.');
    } else if (!_onboarding.a22MotivationProgress) {
      await _update(_onboarding.copyWith(a22MotivationProgress: true));
    } else if (!_onboarding.a23Testimonials) {
      await _update(_onboarding.copyWith(a23Testimonials: true));
    } else if (!_onboarding.a24Task) {
      await _update(_onboarding.copyWith(a24Task: true));
    } else if (_onboarding.a25Wishlist.length < 3) {
      throw Exception('Need to set wishlist first.');
    } else if (_onboarding.a26Commitment == null) {
      throw Exception('Need to set DailyGoal first.');
    } else if (_onboarding.a27Notification == null && !kIsWeb) {
      await _update(_onboarding.copyWith(a27Notification: true));
    } else if (!_onboarding.a28Promise) {
      await _update(_onboarding.copyWith(a28Promise: true));
    } else if (!_onboarding.a29Chat) {
      await _update(_onboarding.copyWith(a29Chat: true));
    } else if (_onboarding.a30PaywallPeriod == null) {
      throw Exception('Need to set PaywallPeriod first.');
    } else {
      throw Exception('Nothing to select next.');
    }
    return _onboarding.route;
  }

  Future<void> setName(final String name) async =>
      _update(_onboarding.copyWith(a02IntroductionName: name));

  Future<void> setGender(final Gender gender) async =>
      _update(_onboarding.copyWith(a04Gender: gender));
  Future<void> setAge(final Age age) async =>
      _update(_onboarding.copyWith(a05Age: age));

  Future<void> setMotivationQ1Result({required final bool result}) async =>
      _update(_onboarding.copyWith(a07MotivationQ1Result: result));
  Future<void> setMotivationQ2Result({required final bool result}) async =>
      _update(_onboarding.copyWith(a08MotivationQ2Result: result));
  Future<void> setMotivationQ3Result({required final bool result}) async =>
      _update(_onboarding.copyWith(a09MotivationQ3Result: result));

  Future<void> setMentalHealthQ1Result(final Frequency frequency) async =>
      _update(_onboarding.copyWith(a12MentalHealthQ1Result: frequency));
  Future<void> setMentalHealthQ2Result(final Frequency frequency) async =>
      _update(_onboarding.copyWith(a13MentalHealthQ2Result: frequency));
  Future<void> setMentalHealthQ3Result(final Frequency frequency) async =>
      _update(_onboarding.copyWith(a14MentalHealthQ3Result: frequency));
  Future<void> setMentalHealthQ4Result(final Frequency frequency) async =>
      _update(_onboarding.copyWith(a15MentalHealthQ4Result: frequency));
  Future<void> setMentalHealthQ5Result(final Frequency frequency) async =>
      _update(_onboarding.copyWith(a16MentalHealthQ5Result: frequency));

  Future<void> setStatementQ1Result({required final bool result}) async =>
      _update(_onboarding.copyWith(a20StatementQ1Result: result));
  Future<void> setStatementQ2Result({required final bool result}) async =>
      _update(_onboarding.copyWith(a21StatementQ2Result: result));

  Future<void> setWishlist(final List<String> wishlist) async =>
      wishlist.isNotEmpty
          ? _update(_onboarding.copyWith(a25Wishlist: wishlist))
          : null;
  Future<void> setDailyGoal(final DailyGoal dailyGoal) async =>
      _update(_onboarding.copyWith(a26Commitment: dailyGoal));
  Future<void> setPaywallPeriod(final PaywallPeriod period) async =>
      _update(_onboarding.copyWith(a30PaywallPeriod: period));
}

@Riverpod(dependencies: <Object>[Onboarding], keepAlive: true)
String name(final NameRef ref) => ref.watch(
  onboardingProvider.select(
    (final AsyncValue<OnboardingState> onboarding) =>
        onboarding
            .whenData(
              (final OnboardingState onboarding) =>
                  onboarding.a02IntroductionName,
            )
            .valueOrNull ??
        '',
  ),
);
