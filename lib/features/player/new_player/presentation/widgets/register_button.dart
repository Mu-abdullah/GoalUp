import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/circle_progress.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../data/model/create_new_player.dart';
import '../cubits/create_player_cubit/create_player_cubit.dart';
import '../cubits/get_image_cubit/get_image_cubit.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.newPlayerCubit});

  final NewPlayerCubit newPlayerCubit;

  @override
  Widget build(BuildContext context) {
    var imageCubit = GetImageCubit.get(context);
    return BlocConsumer<CreatePlayerCubit, CreatePlayerState>(
      listener: (context, state) {
        if (state is CreatePlayerLoading ||
            imageCubit.state is UploadImageLoading) {
          showProgressIndicator(context);
        } else if (state is CreatePlayerLoaded) {
          CustomSnackbar.showTopSnackBar(
            context,
            message: LangKeys.playerCreatedSuccessfully,
          );
          Navigator.pop(context);
        } else if (state is CreatePlayerError) {
          CustomSnackbar.showTopSnackBar(
            context,
            message: state.message,
            isError: true,
            translate: false,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final cubit = CreatePlayerCubit.get(context);
        return AppButton(
          onTap: () async {
            if (imageCubit.image == null) {
              CustomSnackbar.showTopSnackBar(
                context,
                message: LangKeys.imageRequired,
                isError: true,
              );
              return;
            }
            if (newPlayerCubit.position == null ||
                newPlayerCubit.nationality == null) {
              CustomSnackbar.showTopSnackBar(
                context,
                message: LangKeys.countryAndPositionRequired,
                isError: true,
              );
              return;
            }
            if (newPlayerCubit.formKey.currentState!.validate()) {
              final newPlayer = NewPlayerCubit.get(context);
              try {
                await imageCubit.uploadPhoto().then((onValue) async {
                  final player = CreateNewPlayer(
                    id: newPlayer.id.text,
                    name: newPlayer.name.text,
                    contactNumber: newPlayer.phone.text,
                    nid: newPlayer.nid,
                    birthday: newPlayer.birth.text,
                    createdAt: DateTime.now().toString(),
                    enrollmentDate: newPlayer.enroll.text,
                    position: newPlayer.position!,
                    nationality: newPlayer.nationality!,
                    image: onValue,
                  );
                  debugPrint('Player JSON: ${player.toJson()}');
                  await cubit.createPlayer(player.toJson());
                });
              } catch (error) {
                debugPrint("Error: $error");
                if (context.mounted) {
                  CustomSnackbar.showTopSnackBar(
                    context,
                    message: error.toString(),
                    isError: true,
                    backgroundColor: AppColors.yellow,
                    textColor: AppColors.black,
                  );
                }
              }
            }
          },
          isLoading:
              imageCubit.state is UploadImageLoading ||
              state is CreatePlayerLoading,
          text: LangKeys.register,
        );
      },
    );
  }
}
