import 'package:flutter/material.dart';
import '../../extextions/extentions.dart';
import 'package:shimmer/shimmer.dart';

import '../../language/lang_keys.dart';
import '../widgets/app_text.dart';

class ShimmerLoadingText extends StatelessWidget {
  const ShimmerLoadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomShimmer(
        child: AppText(
          context.translate(LangKeys.loading),
          maxLines: 20,
          textAlign: TextAlign.center,
          height: 2,
          fontSize: context.bodySmall!.fontSize,
        ),
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.child,
    this.baseColor = Colors.white,
    this.highlightColor = Colors.grey,
  });

  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}
