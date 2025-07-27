import '../../../../../core/entities/evaluations_entity.dart';

class EvaluationsModel extends EvaluationsEntity {
  EvaluationsModel({
    required super.id,
    required super.createdAt,
    required super.criteria,
    required super.player,
    required super.playerScore,
    required super.evaluationDay,
  });

  factory EvaluationsModel.fromJson(Map<String, dynamic> json) =>
      EvaluationsModel(
        id: json['id'],
        createdAt: json['created_at'],
        criteria: json['criteria'],
        player: json['player'],
        playerScore: json['player_score'],
        evaluationDay: json['evaluation_day'] ?? '',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'created_at': createdAt,
    'criteria': criteria,
    'player': player,
    'player_score': playerScore,
    'evaluation_day': evaluationDay,
  };
}
