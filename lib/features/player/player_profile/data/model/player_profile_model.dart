import '../../../../../core/entities/player_entity.dart';

class PlayerProfileModel extends PlayerEntity {
  const PlayerProfileModel({
    super.id,
    super.name,
    super.birthday,
    super.contactNumber,
    super.nid,
    super.enrollmentDate,
    super.nationality,
    super.image,
    super.position,
  });
  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) {
    return PlayerProfileModel(
      id: json['id'],
      name: json['name'],
      birthday: json['birthday'],
      contactNumber: json['contact_number'],
      nid: json['nid'],
      enrollmentDate: json['enrollment_date'],
      nationality: json['nationality']['flag'],
      image: json['image'],
      position: json['position']['code'],
    );
  }
}
