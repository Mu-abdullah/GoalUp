import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/home_academy_model.dart';
import '../cubits/home_academy_cubit/home_academy_cubit.dart';

class AcademyNameLogo extends StatelessWidget {
  const AcademyNameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,

      child: BlocBuilder<HomeAcademyCubit, HomeAcademyState>(
        builder: (context, state) {
          if (state is HomeAcademyLoading) {
            return _buildLoadingState();
          } else if (state is HomeAcademyLoaded) {
            return _buildLoadedState(state.academy);
          } else if (state is HomeAcademError) {
            return _buildErrorState(state.message);
          }
          return _buildDefaultState();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: _buildGlassyDecoration(),
      child: const ListLoadingShimmer(itemCount: 1, height: 0.1),
    );
  }

  Widget _buildLoadedState(HomeAcademyModel academy) {
    final isLogoNull = academy.logo == '' || academy.logo == null;

    return Container(
      decoration: _buildGlassyDecoration(),
      child: Stack(
        children: [
          _buildAnimatedBackground(),

          Padding(
            padding: AppPadding.mediumPadding,
            child: Row(
              children: [
                _buildEnhancedLogo(isLogoNull, academy.logo),
                Spacer(),
                _buildAcademyNameSection(academy.name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.black.withValues(alpha: 0.1),
            AppColors.blueAccent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedLogo(bool isLogoNull, String? logoUrl) {
    return DropShadowImage(
      image:
          isLogoNull
              ? Image.asset(AppImages.logo, fit: BoxFit.cover)
              : Image.network(
                logoUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Image.asset(AppImages.logo, fit: BoxFit.cover),
              ),
    );
  }

  Widget _buildAcademyNameSection(String? academyName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main academy name
        AppText(
          academyName ?? LangKeys.somethingWentWrong,
          translate: academyName == null,
          fontSize: 22,
          isBold: true,
          color: AppColors.black,
        ),

        const SizedBox(height: 4),

        // Subtitle or tagline
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.black.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
          child: const AppText(
            LangKeys.footballAcademy,
            fontSize: 12,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildGlassyDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppColors.scaffoldBackground.withValues(alpha: 0.9),
      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
      boxShadow: [
        // Main shadow
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          spreadRadius: 0,
          offset: const Offset(0, 10),
        ),
        // Inner glow
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.1),
          blurRadius: 10,
          spreadRadius: -5,
          offset: const Offset(0, -5),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      decoration: _buildGlassyDecoration(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: AppColors.red, size: 32),
            const SizedBox(height: 8),
            AppText(
              message,
              translate: false,
              color: AppColors.red,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultState() {
    return Container(
      decoration: _buildGlassyDecoration(),
      child: const Center(
        child: AppText(LangKeys.somethingWentWrong, color: AppColors.grey),
      ),
    );
  }
}
