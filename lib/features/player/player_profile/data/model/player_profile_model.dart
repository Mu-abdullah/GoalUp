import '../../../../../core/entities/player_entity.dart';

class PlayerProfileModel extends PlayerEntity {
  final String? academy;
  final String? academyLogo;
  final String? academyplayerId;
  final String? enrollmentDate;
  const PlayerProfileModel({
    super.id,
    super.name,
    super.birthday,
    super.contactNumber,
    super.nid,

    super.nationality,
    super.image,
    super.position,
    this.academy,
    this.academyLogo,
    this.academyplayerId,
    this.enrollmentDate,
  });
  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) {
    return PlayerProfileModel(
      id: json['id'],
      name: json['name'],
      birthday: json['birthday'],
      contactNumber: json['contact_number'],
      nid: json['nid'],
      nationality: json['nationality']['flag'],
      image: json['image'] ?? '',
      position: json['position']['code'],
      academy: null,
    );
  }
  factory PlayerProfileModel.fromAnotherTableJson(Map<String, dynamic> json) {
    return PlayerProfileModel(
      academyplayerId: json['id'],
      id: json['players']['id'],
      name: json['players']['name'],
      birthday: json['players']['birthday'],
      contactNumber: json['players']['contact_number'],
      nid: json['players']['nid'],
      enrollmentDate: json['enrollment_date'],
      nationality: json['players']['nationality']['flag'],
      image: json['players']['image'],
      position: json['players']['position']['code'],
      academy: json['academy']['name'] ?? '',
      academyLogo: json['academy']['logo'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'birthday': birthday,
    'contact_number': contactNumber,
    'nid': nid,
    'nationality': nationality,
    'image': image,
    'position': position,
    'academy': academy,
  };
}
