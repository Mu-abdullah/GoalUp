import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/status/subscription_status.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../coach_home_page/presentation/cubits/home_academy_cubit/home_academy_cubit.dart';
import '../../data/model/coach_model.dart';
import 'coach_profile_bottom_sheet.dart';

class CoachInfo extends StatelessWidget {
  const CoachInfo({super.key, required this.coach});
  final CoachModel coach;
  @override
  Widget build(BuildContext context) {
    var daysActive = HomeAcademyCubit.get(context).academy;
    bool isDemo = daysActive!.subscriptionStatus == SubscriptionStatus.demo;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: AppBorderRadius.smallRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: AppPadding.symmetric(),
      child: Row(
        spacing: 16,
        children: [
          Container(
            height: Statics.defaultSize * 0.7,
            width: Statics.defaultSize * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(coach.image!),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.darkBlue, width: 2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(coach.name!, isBold: true, isTitle: true, tr: false),
                AppText(
                  isDemo
                      ? context.tr(LangKeys.demo)
                      : "${context.tr(LangKeys.subscriptionUntil)} ${daysActive.activeTo!}",
                  maxLines: 3,
                  tr: false,
                  isBold: isDemo,
                  color: isDemo ? AppColors.red : AppColors.black,
                ),
              ],
            ),
          ),
          AppText(coach.nationality!, isTitle: true, tr: false),
          InkWell(
            onTap: () {
              customShowBottomSheet(
                context: context,
                widget: CoachProfileBottomSheet(coach: coach),
                title: coach.name!,
                translated: false,
              );
            },
            child: CircleAvatar(
              backgroundColor: AppColors.darkBlue,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
