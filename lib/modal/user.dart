
class UserModel {
  String uid;
  String name;
  String email;
  String dob;
  String gender;

  UserModel({
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
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    dob: json['dob'],
    gender: json['gender'],
  );
}
