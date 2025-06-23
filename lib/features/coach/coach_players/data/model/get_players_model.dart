import '../../../../../core/entities/player_entity.dart';

class GetPlayersModel extends PlayerEntity {
  GetPlayersModel({
    super.id,
    super.name,
    super.birthday,
    super.image,
    super.position,
  });

  factory GetPlayersModel.fromJson(Map<String, dynamic> json) =>
      GetPlayersModel(
        id: json['id'],
        name: json['name'],
        birthday: json['birthday'],
        image: json['image'],
        position: json['position']['code'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday,
      'image': image,
      'position': position,
    };
  }
}
