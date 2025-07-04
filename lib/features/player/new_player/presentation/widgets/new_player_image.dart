import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../cubits/get_image_cubit/get_image_cubit.dart';

class NewPlayerImage extends StatelessWidget {
  const NewPlayerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetImageCubit, GetImageState>(
      builder: (context, state) {
        var cubit = GetImageCubit.get(context);
        return Container(
          height: Statics.defaultSize * 2.5,
          width: Statics.defaultSize * 2.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(),
            image: DecorationImage(
              image:
                  cubit.image == null
                      ? AssetImage(AppImages.player)
                      : FileImage(cubit.image!),
            ),
          ),

          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    cubit.pickImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.darkBlue,
                    radius: 20,
                    child: Icon(Icons.camera_alt, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
