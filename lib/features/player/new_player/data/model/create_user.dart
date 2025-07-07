class CreateUser {
  final String? email;
  final String? playerId;
  final String? createdAt;
  final String? id;

  CreateUser({this.email, this.playerId, this.createdAt, this.id});

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
    email: json['email'],
    playerId: json['player_id'],
    createdAt: json['created_at'],
    id: json['id'],
  );
  Map<String, dynamic> toJson() => {
    'email': email,
    'player_id': playerId,
    'created_at': createdAt,
    'id': id,
  };
}
