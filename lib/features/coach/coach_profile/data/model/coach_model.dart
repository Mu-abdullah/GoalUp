import '../../../../../core/entities/coach_entity.dart';

class CoachModel extends CoachEntity {
  final String? logo;
  CoachModel({
    super.id,
    super.name,
    super.email,
    super.phoneNumber,
    super.academy,
    super.nationality,
    super.qualifications,
    super.image,
    this.logo,
  });

  factory CoachModel.fromJson(Map<String, dynamic> json) => CoachModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    phoneNumber: json['phone_number'] ?? '',
    academy: json['academy']['name'] ?? '',
    nationality: json['nationality']['flag'] ?? '',
    qualifications: json['qualifications'] ?? '',
    image: json['image'] ?? '',
    logo: json['academy']['logo'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone_number': phoneNumber,
    'academy': academy,
    'nationality': nationality,
    'qualifications': qualifications,
    'image': image,
    'logo': logo,
  };
}
