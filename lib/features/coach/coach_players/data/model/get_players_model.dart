import '../../../../../core/entities/academy_players_entity.dart';

class GetPlayersModel extends AcademyPlayersEntity {
  final String? position;
  final String? birthday;
  final String? image;

  GetPlayersModel({
    super.id,
    super.academy,
    super.player,
    super.enrollmentDate,
    this.position,
    this.birthday,
    this.image,
  });

  factory GetPlayersModel.fromJson(Map<String, dynamic> json) =>
      GetPlayersModel(
        id: json['players']['id'],
        academy: json['academy']['name'],
        player: json['players']['name'],
        image: json['players']['image'],
        birthday: json['players']['birthday'],
        position: json['players']['position']['code'],
        enrollmentDate: json['enrollment_date'],
      );
}
