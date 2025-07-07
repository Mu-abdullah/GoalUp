import '../../../../../core/entities/academy_players_entity.dart';

class CreateAcademyPlayer extends AcademyPlayersEntity {
  CreateAcademyPlayer({
    required super.id,
    required super.academy,
    required super.player,
    required super.createdAt,
  });

  factory CreateAcademyPlayer.fromJson(Map<String, dynamic> json) =>
      CreateAcademyPlayer(
        id: json['id'],
        academy: json['academy'],
        player: json['player'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'academy': academy,
    'player': player,
    'created_at': createdAt,
  };
}
