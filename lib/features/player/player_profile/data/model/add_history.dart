import '../../../../../core/entities/player_history.dart';

class AddHistoryModel extends PlayerHistoryEntity {
  AddHistoryModel({
    super.id,
    super.playerId,
    super.createdAt,
    super.academyName,
    super.from,
    super.to,
  });

  factory AddHistoryModel.fromJson(Map<String, dynamic> json) =>
      AddHistoryModel(
        id: json['id'],
        playerId: json['player_id'],
        createdAt: json['created_at'],
        academyName: json['academy_id'],
        from: json['from'],
        to: json['to'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'player_id': playerId,
    'created_at': createdAt,
    'academy_id': academyName,
    'from': from,
    'to': to,
  };
}
