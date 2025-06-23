import '../../../../core/entities/coach_entity.dart';

class CheckCoachModel extends CoachEntity {
  CheckCoachModel({super.id, super.name, super.academy, super.uid});
  factory CheckCoachModel.fromJson(Map<String, dynamic> json) =>
      CheckCoachModel(
        id: json['id'],
        name: json['name'],
        academy: json['academy']['id'],
       
      );
}
