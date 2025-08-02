import '../../../../../core/entities/evaluations_entity.dart';

class PlayerRatingModel extends EvaluationsEntity {
  final String? category;
  final String? categoryId;
  final String? criteriaId;
  final int? maxScore;

  PlayerRatingModel({
    required super.id,
    required super.createdAt,
    required super.criteria,
    required super.player,
    required super.playerScore,
    required super.evaluationDay,
    this.category,
    this.categoryId,
    this.criteriaId,
    this.maxScore,
  });

  factory PlayerRatingModel.fromJson(Map<String, dynamic> json) {
    // معالجة الحالات الفارغة
    final criteria = json['criteria'] as Map<String, dynamic>? ?? {};
    final category = criteria['category'] as Map<String, dynamic>? ?? {};

    return PlayerRatingModel(
      id: json['id']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      criteria: criteria['name']?.toString() ?? 'غير معروف',
      player: json['player']?.toString() ?? '',
      playerScore: int.tryParse(json['player_score']?.toString() ?? '0') ?? 0,
      category: category['name']?.toString(),
      categoryId: category['id']?.toString(),
      criteriaId: criteria['id']?.toString(),
      evaluationDay: json['evaluation_day']?.toString() ?? '',
      maxScore:
          criteria['max'] != null
              ? int.tryParse(criteria['max'].toString())
              : null,
    );
  }

  // get average score for the player
  double get averageScore {
    if (maxScore == null || maxScore == 0) return 0.0;
    return (playerScore ?? 0) / maxScore!;
  }
}
