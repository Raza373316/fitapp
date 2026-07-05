import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/user_model.dart';

/// Reads the `users/{uid}` document your signup flow already writes.
/// Kept separate from AuthRepository since this is a plain data read,
/// not an auth action.
class UserRepository {
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  /// Returns null if the doc doesn't exist yet (e.g. the Firestore write
  /// failed during signup even though the Auth account was created).
  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromJson(doc.data()!);
  }
}