import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../language/lang_keys.dart';
import '../../style/color/app_color.dart';
import '../../style/statics/app_statics.dart';
import '../../style/statics/strings_static.dart';
import '../../style/widgets/app_text.dart';
import '../../style/custom_widgets/custom_app_bar.dart';
import 'language_cubit/language_cubit.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LangKeys.changeLanguage),
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground.withValues(alpha: 0.9),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<LanguageCubit, String>(
                builder: (context, selectedLanguage) {
                  return ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: 2,
                    separatorBuilder:
                        (_, __) => Divider(
                          color: AppColors.black.withValues(alpha: 0.1),
                          height: 24,
                        ),
                    itemBuilder: (context, index) {
                      final languages = [
                        {
                          'name': StringsStatic.english,
                          'code': 'en',
                          'flag': '🇬🇧',
                        },
                        {
                          'name': StringsStatic.arabic,
                          'code': 'ar',
                          'flag': '🇸🇦',
                        },
                      ];
                      return _buildLanguageTile(
                        context,
                        languages[index]['name']!,
                        languages[index]['code']!,
                        languages[index]['flag']!,
                        selectedLanguage,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String languageName,
    String languageCode,
    String flag,
    String selectedLanguage,
  ) {
    final isSelected = selectedLanguage == languageCode;

    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: isSelected ? 1.02 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.largeRadius,
          color: isSelected ? AppColors.white : Colors.transparent,
          border: Border.all(
            color:
                isSelected
                    ? AppColors.black
                    : AppColors.black.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: AppBorderRadius.largeRadius,
            onTap: () => _handleLanguageChange(context, languageCode),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                spacing: 16,
                children: [
                  AppText(flag, tr: false),
                  Expanded(
                    child: AppText(
                      languageName,
                      isTitle: isSelected,
                      tr: false,
                      isBold: isSelected,
                      color: isSelected ? AppColors.black : AppColors.grey,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        isSelected
                            ? Icon(
                              HugeIcons.strokeRoundedCheckmarkCircle03,
                              color: AppColors.black,
                              size: 28,
                            )
                            : const SizedBox(width: 28),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLanguageChange(BuildContext context, String languageCode) {
    context.read<LanguageCubit>().changeLanguage(languageCode);
    // final newLocale = Locale(languageCode);
    // MainSport.updateAppLocale(context, newLocale);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.black,
        content: AppText(
          '${context.tr(LangKeys.changeLanguage)} '
          '${context.tr(LangKeys.english)}',
          color: AppColors.white,
          tr: false,
        ),
        action: SnackBarAction(
          label: context.tr(LangKeys.cancel),
          textColor: AppColors.white,
          onPressed: () {
            // Handle undo logic
          },
        ),
      ),
    );
  }
}
