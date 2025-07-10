import '../../../../../core/entities/player_entity.dart';

class CreateNewPlayer extends PlayerEntity {
  CreateNewPlayer({
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

  factory CreateNewPlayer.fromJson(Map<String, dynamic> json) =>
      CreateNewPlayer(
        id: json['id'],
        name: json['name'],
        contactNumber: json['contact_number'],
        nid: json['nid'],
        birthday: json['birthday'],
        createdAt: json['created_at'],
         position: json['position'],
        nationality: json['nationality'],
        image: json['image'],
      );

  // toJson
  Map<String, dynamic> toJson() => {
    'name': name,
    'contact_number': contactNumber,
    'nid': nid,
    'birthday': birthday,
    'created_at': DateTime.now().toString(),
    'position': position,
    'nationality': nationality,
    'image': image,
    'id': id,
  };
}
