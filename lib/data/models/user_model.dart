/// Firestore-backed user profile, created at sign-up and read by the
/// auth feature. Keep this framework-agnostic (no Firebase imports here) so
/// it can be tested and reused without pulling in Firebase.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String dob;
  final String gender;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'dob': dob,
        'gender': gender,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        dob: json['dob'] as String,
        gender: json['gender'] as String,
      );
}
