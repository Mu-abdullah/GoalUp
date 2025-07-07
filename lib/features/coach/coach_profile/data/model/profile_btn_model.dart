import '../../../../../core/entities/buttons_entity.dart';
import '../../../../../core/style/color/app_color.dart';

class ProfileBtnModel extends ButtonsEntity {
  ProfileBtnModel({
    super.titleColor = AppColors.black,
    super.backgroundColor = AppColors.white,
    required super.title,
    required super.icon,
    required super.iconColor,
    required super.onTap,
  });
}
