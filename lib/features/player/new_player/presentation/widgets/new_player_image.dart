import 'package:flutter/foundation.dart';
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
        final cubit = GetImageCubit.get(context);

        return Container(
          height: Statics.defaultSize * 2.5,
          width: Statics.defaultSize * 2.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(),
            image: DecorationImage(
              image: _getImageProvider(cubit),
              fit: BoxFit.cover,
            ),
          ),
          child: _buildCameraButton(cubit),
        );
      },
    );
  }

  ImageProvider _getImageProvider(GetImageCubit cubit) {
    if (cubit.isEdit) {
      if (kIsWeb) {
        if (cubit.pickedBytes != null) {
          return MemoryImage(cubit.pickedBytes!);
        } else if (cubit.editImageUrl?.isNotEmpty == true) {
          return NetworkImage(cubit.editImageUrl!);
        } else {
          return AssetImage(AppImages.player);
        }
      } else {
        if (cubit.image != null) {
          return FileImage(cubit.image!);
        } else if (cubit.editImageUrl?.isNotEmpty == true) {
          return NetworkImage(cubit.editImageUrl!);
        } else {
          return AssetImage(AppImages.player);
        }
      }
    } else {
      if (kIsWeb) {
        if (cubit.pickedBytes != null) {
          return MemoryImage(cubit.pickedBytes!);
        } else {
          return AssetImage(AppImages.player);
        }
      } else {
        if (cubit.image != null) {
          return FileImage(cubit.image!);
        } else {
          return AssetImage(AppImages.player);
        }
      }
    }
  }

  Widget _buildCameraButton(GetImageCubit cubit) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: InkWell(
            onTap: cubit.pickImage,
            child: CircleAvatar(
              backgroundColor: AppColors.darkBlue,
              radius: 20,
              child: Icon(Icons.camera_alt, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
