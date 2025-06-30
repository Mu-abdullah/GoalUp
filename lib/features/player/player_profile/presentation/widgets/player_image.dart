import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/player_profile_model.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';

class PlayerImage extends StatelessWidget {
  const PlayerImage({super.key, required this.player, required this.cubit});

  final PlayerProfileModel player;
  final PlayerProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imagePreview(context),
      child: Container(
        height: context.height(percent: .7),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                player.image == null
                    ? AssetImage(AppImages.player)
                    : NetworkImage(player.image ?? ''),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),

                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                player.name!,
                                color: AppColors.white,
                                translate: false,
                                isBold: true,
                                isTitle: true,
                              ),
                              AppText(
                                player.academy ?? LangKeys.notRegistered,
                                color:
                                    player.academy == null
                                        ? AppColors.red
                                        : AppColors.white,
                                textAlign: TextAlign.start,
                                translate: player.academy == null,
                                isBold: player.academy == null,
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                        AppText(
                          player.nationality!,
                          fontSize: 24,
                          translate: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  imagePreview(BuildContext context) {
    return player.image != null
        ? () {
          context.pushNamed(
            RoutesNames.imagePreview,
            arguments: {
              'imageUrl': player.image,
              'title': player.name ?? 'Player Image',
            },
          );
        }
        : null;
  }
}
