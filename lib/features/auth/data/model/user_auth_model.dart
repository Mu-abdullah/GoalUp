class UserAuthModel {
  final String? email;
  final String? playerId;

  UserAuthModel({this.email, this.playerId});

  factory UserAuthModel.fromJson(Map<String, dynamic> json) =>
      UserAuthModel(email: json['email'], playerId: json['player_id']);
}
