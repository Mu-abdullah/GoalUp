import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/style/statics/app_statics.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../../data/model/player_profile_model.dart';

class PlayerImage extends StatelessWidget {
  const PlayerImage({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imagePreview(context),
      child: Container(
        height: Statics.defaultSize * 1.5,
        width: Statics.defaultSize * 1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                player.image == null
                    ? AssetImage(AppImages.player)
                    : NetworkImage(player.image ?? ''),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
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