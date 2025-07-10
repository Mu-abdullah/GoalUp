import '../../../../../core/entities/academy_players_entity.dart';

class CreateAcademyPlayer extends AcademyPlayersEntity {
  CreateAcademyPlayer({
    required super.id,
    required super.academy,
    required super.player,
    required super.createdAt,
    required super.enrollmentDate
  });

  factory CreateAcademyPlayer.fromJson(Map<String, dynamic> json) =>
      CreateAcademyPlayer(
        id: json['id'],
        academy: json['academy'],
        player: json['player'],
        createdAt: json['created_at'],
        enrollmentDate: json['enrollment_date'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'academy': academy,
    'player': player,
    'created_at': createdAt,
    'enrollment_date': enrollmentDate
  };
}
