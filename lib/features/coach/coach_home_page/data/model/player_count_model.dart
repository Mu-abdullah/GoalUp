import '../../../../../core/entities/academy_players_entity.dart';

class PlayerCountModel extends AcademyPlayersEntity {
  PlayerCountModel({required super.academy});

  factory PlayerCountModel.fromJson(Map<String, dynamic> json) =>
      PlayerCountModel(academy: json['id']);
}
