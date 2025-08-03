import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/coach_model.dart';

class CoachProfileBottomSheet extends StatelessWidget {
  const CoachProfileBottomSheet({super.key, required this.coach});
  final CoachModel coach;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCoachImage(coach.image!, 100),
                _buildCoachImage(coach.logo!, 80),
              ],
            ),
          ),
        ),
        ..._buildInfoItems(context),
        Padding(
          padding: AppPadding.symmetric(),
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                flex: 2,
                child: AppButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: LangKeys.done,
                ),
              ),
              Expanded(
                flex: 1,
                child: AppButton(
                  onTap: () {
                    Navigator.pop(context);
                    CustomSnackbar.showTopSnackBar(
                      context,
                      message: LangKeys.comingSoon,
                      isError: true,
                    );
                  },
                  text: LangKeys.edit,
                  icon: HugeIcons.strokeRoundedEdit01,
                  backGroundColor: AppColors.yellow,
                  iconColor: AppColors.black,
                  txtColor: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoachImage(String imageUrl, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(Icons.person, size: size * 0.6),
        ),
      ),
    );
  }

  List<Widget> _buildInfoItems(BuildContext context) {
    return [
      _buildInfoRow(
        HugeIcons.strokeRoundedSmartPhone01,
        coach.phoneNumber ?? '',
        false,
      ),
      _buildDivider(),
      _buildInfoRow(HugeIcons.strokeRoundedMail01, coach.email ?? '', false),
      _buildDivider(),
      _buildInfoRow(HugeIcons.strokeRoundedSchool, coach.academy ?? '', false),
      _buildDivider(),
      _buildInfoRow(
        HugeIcons.strokeRoundedWork,
        coach.qualifications?.isNotEmpty == true
            ? coach.qualifications!
            : LangKeys.noQualifications,
        coach.qualifications?.isNotEmpty != true,
      ),
      _buildDivider(),
      _buildInfoRow(
        HugeIcons.strokeRoundedFlag01,
        coach.nationality ?? '',
        false,
      ),
    ];
  }

  Widget _buildDivider() {
    return Padding(
      padding: AppPadding.symmetric(horizontal: 24),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, bool translate) {
    return Padding(
      padding: AppPadding.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppPadding.smallPadding,
            decoration: BoxDecoration(
              color: AppColors.darkBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: AppColors.darkBlue),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: AppText(
                text,
                translate: translate,
                fontSize: 16,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
