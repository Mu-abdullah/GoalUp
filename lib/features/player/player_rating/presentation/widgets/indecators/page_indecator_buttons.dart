import 'package:sport/core/extextions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../cubits/player_rating_cubit/player_rating_cubit.dart';

class PageIndicatorButtons extends StatelessWidget {
  const PageIndicatorButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.langCode == 'ar';
    return BlocBuilder<PlayerRatingCubit, PlayerRatingState>(
      builder: (context, state) {
        final cubit = PlayerRatingCubit.get(context);
        final totalPages = cubit.pages.length;
        final currentPage = state.currentPage;

        return Padding(
          padding: AppPadding.symmetricPadding(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavigationButton(
                isEnabled: currentPage > 0,
                onPressed: cubit.previousPage,
                icon:
                    isArabic
                        ? HugeIcons.strokeRoundedNext
                        : HugeIcons.strokeRoundedPrevious,
                label: LangKeys.previous,
                isReversed: true,
              ),

              _NavigationButton(
                isEnabled: currentPage < totalPages - 1,
                onPressed: cubit.nextPage,
                icon:
                    isArabic
                        ? HugeIcons.strokeRoundedPrevious
                        : HugeIcons.strokeRoundedNext,
                label: LangKeys.next,
                showProgress: true,
                progress: (currentPage + 1) / totalPages,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isReversed;
  final bool showProgress;
  final double? progress;

  const _NavigationButton({
    required this.isEnabled,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isReversed = false,
    this.showProgress = false,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    var color = AppColors.black;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isEnabled ? 1.0 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: AppPadding.symmetricPadding(vertical: 10),
            constraints: const BoxConstraints(minWidth: 120),
            child: Row(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: isReversed ? TextDirection.rtl : TextDirection.ltr,
              children: [
                AppText(label, fontWeight: FontWeight.w600, color: color),
                Icon(icon, size: 20, color: color),
                if (showProgress && progress != null) ...[
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 2,
                      backgroundColor: color.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
