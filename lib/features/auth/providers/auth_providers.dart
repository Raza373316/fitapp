import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// Single shared instance of the repository. Swap this out with a fake in
/// tests via `ProviderScope(overrides: [authRepositoryProvider.overrideWithValue(...)])`.
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

/// Live Firebase auth state - the splash/auth gate watches this to decide
/// whether to show the app or the login flow.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

/// Drives the login/signup screens: exposes AsyncLoading while a request is
/// in flight and AsyncError with the failure message if it fails, so the UI
/// can show a spinner/toast without holding that state itself.
class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // No initial async work - this notifier only reacts to login()/signUp() calls.
  }

  Future<bool> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await AsyncValue.guard(
      () => repo.login(email: email, password: password),
    );
    state = result;
    return !result.hasError;
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String dob,
    required String gender,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await AsyncValue.guard(
      () => repo.signUp(
        name: name,
        email: email,
        password: password,
        dob: dob,
        gender: gender,
      ),
    );
    state = result;
    return !result.hasError;
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);
