import '../../../../../core/entities/buttons_entity.dart';
import '../../../../../core/style/color/app_color.dart';

class AdminSectionModel extends ButtonsEntity {
  AdminSectionModel({
   
    required super.titleColor,
    required super.title,
    required super.icon,
    required super.onTap,
    super.backgroundColor = AppColors.scaffoldBackground,
  });
}
