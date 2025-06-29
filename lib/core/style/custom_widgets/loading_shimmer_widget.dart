import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/style/widgets/app_text.dart';

import '../../language/lang_keys.dart';
import '../color/app_color.dart';
import '../statics/app_statics.dart';
import 'custom_shimmer.dart';

class ListLoadingShimmer extends StatelessWidget {
  const ListLoadingShimmer({super.key, this.itemCount = 10, this.height});
  final int itemCount;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder:
          (_, __) => CustomShimmer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: context.height(percent: height ?? 0.28),
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
                child: Column(
                  children: [
                    Container(
                      height: context.height(percent: 0.02),
                      color: AppColors.blueAccent,
                    ),
                    Container(
                      height: context.height(percent: 0.02),
                      color: AppColors.scaffoldBackground,
                    ),
                  ],
                ),
              ),
            ),
          ),
      itemCount: itemCount,
    );
  }
}

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
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
      child: CustomShimmer(child: AppText(LangKeys.loading)),
    );
  }
}
