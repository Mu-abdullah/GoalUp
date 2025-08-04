import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../cubits/update_cubit/update_cubit.dart';
import '../cubits/update_image_cubit/update_image_cubit.dart';

class EditPlayerImage extends StatelessWidget {
  const EditPlayerImage({super.key, required this.cubit});

  final UpdateCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateImageCubit, UpdateImageState>(
      builder: (context, state) {
        final imageCubit = UpdateImageCubit.get(context);

        return SizedBox(
          height: Statics.defaultSize * 2.5,
          width: Statics.defaultSize * 2.5,
          child: Stack(
            children: [
              _buildImageCircle(imageCubit, cubit),
              _buildCameraButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageCircle(UpdateImageCubit icubit, UpdateCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.black, width: 2),
        image: DecorationImage(
          image: _getImageProvider(icubit, cubit),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCameraButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: InkWell(
        onTap: () => UpdateImageCubit.get(context).pickImage(),
        child: CircleAvatar(
          backgroundColor: AppColors.darkBlue,
          radius: 20,
          child: Icon(Icons.camera_alt, color: AppColors.white),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(
    UpdateImageCubit imageCubit,
    UpdateCubit cubit,
  ) {
    if (kIsWeb && imageCubit.pickedBytes != null) {
      return MemoryImage(imageCubit.pickedBytes!);
    } else if (!kIsWeb && imageCubit.image != null) {
      return FileImage(imageCubit.image!);
    } else if (cubit.player.image != null) {
      return NetworkImage(cubit.player.image!);
    }
    return AssetImage(AppImages.player);
  }
}
