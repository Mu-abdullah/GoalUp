import '../../../../../core/entities/player_history.dart';

class PlayerHistoryModel extends PlayerHistoryEntity {
  PlayerHistoryModel({
    super.id,
    super.playerId,
    super.createdAt,
    super.academyLogo,
    super.academyName,
    super.from,
    super.to,
  });

  factory PlayerHistoryModel.fromJson(Map<String, dynamic> json) =>
      PlayerHistoryModel(
        id: json['id'],
        playerId: json['player_id'],
        createdAt: json['created_at'],
        academyLogo: json['academy']['logo'],
        academyName: json['academy']['name'],
        from: json['from'],
        to: json['to'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'player_id': playerId,
    'created_at': createdAt,
    'academy_logo': academyLogo,
    'academy_name': academyName,
    'from': from,
    'to': to,
  };
}
