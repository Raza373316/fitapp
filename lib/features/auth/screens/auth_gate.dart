import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_foam/features/auth/screens/splash_screen.dart';
import '../../../core/navigation/main_navigation_screen.dart';
import '../providers/auth_providers.dart';
import 'login_screen.dart';

/// Root-level routing decision. This is the *only* place that inspects the
/// Firebase auth stream, so screens never need to check `currentUser`
/// themselves - they just trust they're only shown when signed in.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) => user != null ? const MainNavigationScreen() : const LoginScreen(),
      loading: () => const SplashScreen(),
      error: (_, __) => const LoginScreen(),
    );
  }
}
///////
