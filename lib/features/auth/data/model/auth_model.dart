class AuthModel {
  final String? email;
  final String? password;
  final String? uid;

  AuthModel({this.email, this.password, this.uid});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'uid': uid};
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      uid: json['uid'] as String?,
    );
  }
}
