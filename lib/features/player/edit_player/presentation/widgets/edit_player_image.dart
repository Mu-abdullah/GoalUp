import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../cubits/update_cubit/update_cubit.dart';

class EditPlayerImage extends StatelessWidget {
  const EditPlayerImage({super.key, required this.cubit});

  final UpdateCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: Statics.defaultSize * 2.5,
            width: Statics.defaultSize * 2.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.black, width: 2),
              image: DecorationImage(
                image:
                    cubit.player.image != null && cubit.player.image!.isNotEmpty
                        ? NetworkImage(cubit.player.image!)
                        : AssetImage(AppImages.player),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: AppColors.darkBlue,
                      radius: 20,
                      child: Icon(Icons.camera_alt, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
