class UserInfoModel {
  final String? id;
  final String? createdAt;
  final String? email;
  final String? playerId;
  final String? playerName;

  UserInfoModel({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.playerId,
    this.playerName,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      createdAt: json['created_at'],
      email: json['email'],
      playerId: json['players']['id'],
      playerName: json['players']['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'email': email,
    'player_id': playerId,
  };
}
