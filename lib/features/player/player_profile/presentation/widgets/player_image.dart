import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/routes/routes_name.dart';

import '../../../../../core/style/custom_widgets/back_screen_button.dart';
import '../../../../../core/style/statics/image_test.dart';

class PlayerImageHeader extends StatelessWidget {
  const PlayerImageHeader({
    super.key,
    required this.isAdmin,
    this.imageUrl,
    this.playerName,
  });

  final bool isAdmin;
  final String? imageUrl;
  final String? playerName;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: isAdmin,
      leading: isAdmin ? const BackScreenButton() : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl != null
                ? InkWell(
                  onTap: imagePreview(context),
                  child: Image.network(imageUrl!, fit: BoxFit.cover),
                )
                : Image.asset(AppImages.player, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              child: InkWell(
                onTap: imagePreview(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        imageUrl != null
                            ? NetworkImage(imageUrl!)
                            : AssetImage(AppImages.player), // Replace
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
    return imageUrl != null
        ? () {
          context.pushNamed(
            RoutesNames.imagePreview,
            arguments: {
              'imageUrl': imageUrl,
              'title': playerName ?? 'Player Image',
            },
          );
        }
        : null;
  }
}
