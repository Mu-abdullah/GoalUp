import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../../new_player/data/model/create_new_player.dart';
import '../cubits/update_cubit/update_cubit.dart';
import '../cubits/update_image_cubit/update_image_cubit.dart';
import '../cubits/update_player_cubit/update_player_cubit.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () async {
        final updateCubit = UpdateCubit.get(context);
        final imageCubit = UpdateImageCubit.get(context);
        final playerCubit = UpdatePlayerCubit.get(context);

        String? newImageUrl;
        try {
          if ((kIsWeb && imageCubit.pickedBytes != null) ||
              (!kIsWeb && imageCubit.image != null)) {
            if (updateCubit.player.image != null &&
                updateCubit.player.image!.isNotEmpty) {
              await imageCubit.repo.deleteOldImage(updateCubit.player.image!);
            }

            if (kIsWeb) {
              newImageUrl = await imageCubit.repo.uploadImageFromPC(
                imageBytes: imageCubit.pickedBytes!,
              );
            } else {
              newImageUrl = await imageCubit.repo.uploadPhotoFromAndroid(
                image: imageCubit.image!,
              );
            }
          }
        } catch (e) {
          debugPrint("Image upload error: $e");
        }

        final updatedPlayer = CreateNewPlayer(
          id: updateCubit.player.id,
          name: updateCubit.name.text,
          contactNumber: updateCubit.phone.text,
          nid: updateCubit.nidController.text,
          birthday: updateCubit.birth.text,
          position: updateCubit.position,
          image: newImageUrl ?? updateCubit.player.image,
          nationality: updateCubit.player.nationality,
        );
        debugPrint("updatedPlayer: ${updatedPlayer.toJson()}");
        await playerCubit.updatePlayer(updatedPlayer);
        if (context.mounted) {
          CustomSnackbar.showTopSnackBar(
            context,
            message: LangKeys.addSuccessfully,
          );
          Navigator.pop(context);
        }
      },
      text: LangKeys.update,
    );
  }
}
