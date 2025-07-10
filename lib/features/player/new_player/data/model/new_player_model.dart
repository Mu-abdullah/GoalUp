import '../../../../../core/entities/player_entity.dart';

class NewPlayerModel extends PlayerEntity {
  NewPlayerModel({
    required super.id,
    required super.name,
    required super.contactNumber,
    required super.nid,
    required super.birthday,
    required super.createdAt,
    required super.position,
    required super.nationality,
    required super.image,
  });

  factory NewPlayerModel.fromJson(Map<String, dynamic> json) => NewPlayerModel(
    id: json['id'],
    name: json['name'],
    contactNumber: json['contact_number'],
    nid: json['nid'],
    birthday: json['birthday'],
    createdAt: json['created_at'],
    position: json['position']['code'],
    nationality: json['nationality']['name'],
    image: json['image'],
  );

  // toJson
  Map<String, dynamic> toJson() => {
    'name': name,
    'contact_number': contactNumber,
    'nid': nid,
    'birthday': birthday,
    'created_at': createdAt,
    'position': position,
    'nationality': nationality,
    'image': image,
    'id': id,
  };
}
