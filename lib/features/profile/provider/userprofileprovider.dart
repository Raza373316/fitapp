import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';
import '../../auth/providers/auth_providers.dart';
import '../data/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository());

/// The current user's profile (name, email, dob, gender), read from
/// Firestore. Re-fetches automatically whenever authStateChangesProvider
/// emits a different user (login/logout) because it's watched below -
/// not read once and cached forever.
final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authStateChangesProvider);
  final user = authState.value;
  if (user == null) return null;

  final repo = ref.watch(userRepositoryProvider);
  return repo.getUser(user.uid);
});