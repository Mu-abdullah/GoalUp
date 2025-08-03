import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/functions/generate_id.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/circle_progress.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../data/model/create_academy_player.dart';
import '../../data/model/create_new_player.dart';
import '../../data/model/create_user.dart';
import '../cubits/create_player_cubit/create_player_cubit.dart';
import '../cubits/get_image_cubit/get_image_cubit.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.newPlayerCubit});

  final NewPlayerCubit newPlayerCubit;

  @override
  Widget build(BuildContext context) {
    final imageCubit = GetImageCubit.get(context);
    final appCubit = AppUserCubit.get(context);
    final appName = context.tr(LangKeys.appName);

    return BlocConsumer<CreatePlayerCubit, CreatePlayerState>(
      listener: (context, state) {
        final isLoading =
            state is CreatePlayerLoading ||
            imageCubit.state is UploadImageLoading;
        final isLoaded = state is CreatePlayerLoaded;
        final isError = state is CreatePlayerError;

        if (isLoading) {
          showProgressIndicator(context);
        } else {
          Navigator.pop(context);
          if (isLoaded) {
            CustomSnackbar.showTopSnackBar(
              context,
              message: LangKeys.playerCreatedSuccessfully,
            );
            context.pushNamedAndRemoveUntil(RoutesNames.coachHome);
          } else if (isError) {
            CustomSnackbar.showTopSnackBar(
              context,
              message: state.message,
              isError: true,
              translate: false,
            );
          }
        }
      },
      builder: (context, state) {
        final cubit = CreatePlayerCubit.get(context);

        return AppButton(
          text: cubit.isEdit ? LangKeys.update : LangKeys.register,
          isLoading:
              imageCubit.state is UploadImageLoading ||
              state is CreatePlayerLoading,
          onTap:
              () => _handleRegister(
                context,
                imageCubit,
                appCubit,
                appName,
                cubit,
              ),
        );
      },
    );
  }

  Future<void> _handleRegister(
    BuildContext context,
    GetImageCubit imageCubit,
    AppUserCubit appCubit,
    String appName,
    CreatePlayerCubit cubit,
  ) async {
    final playerCubit = newPlayerCubit;
    final now = DateTime.now();

    // Validate required fields
    if (imageCubit.image == null) {
      return _showError(context, LangKeys.imageRequired);
    }

    if (playerCubit.position == null || playerCubit.nationality == null) {
      return _showError(context, LangKeys.countryAndPositionRequired);
    }

    if (!playerCubit.formKey.currentState!.validate()) return;

    try {
      final imageUrl = await imageCubit.uploadPhoto();
      final playerId = playerCubit.id.text;
      final nowStr = now.toString();

      // Generate unique email with improved pattern
      final email = _generatePlayerEmail(
        appName: appName,
        now: now,
        playerCubit: playerCubit,
      );

      final player = CreateNewPlayer(
        id: playerId,
        name: "${playerCubit.firstName.text} ${playerCubit.lastName.text}",
        contactNumber: playerCubit.phone.text,
        nid: playerCubit.nid,
        birthday: playerCubit.birth.text,
        createdAt: nowStr,

        position: playerCubit.position!,
        nationality: playerCubit.nationality!,
        image: imageUrl,
      );

      final academyPlayer = CreateAcademyPlayer(
        id: GenerateId.generateDocumentId(
          academy: appCubit.academyId,
          table: BackendPoint.academysPlayers,
        ),
        academy: appCubit.academyId,
        player: playerId,
        createdAt: nowStr,
        enrollmentDate: playerCubit.enroll.text,
      );

      final user = CreateUser(
        id: GenerateId.generateDocumentId(
          academy: appCubit.academyId,
          table: BackendPoint.users,
        ),
        email: email,
        playerId: playerId,
        createdAt: nowStr,
      );

      debugPrint('Player JSON: ${player.toJson()}');

      await cubit.createPlayer(
        player: player.toJson(),
        academyPlayer: academyPlayer,
        user: user,
      );
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

  String _generatePlayerEmail({
    required String appName,
    required DateTime now,
    required NewPlayerCubit playerCubit,
  }) {
    // Extract components safely
    final appPrefix =
        appName.length >= 2
            ? appName.substring(0, 2).toLowerCase()
            : appName.padRight(2, 'x');

    final datePart = DateFormat('HHmmss').format(now);
    final year = DateFormat('yy').format(now);

    final lastName = playerCubit.romanLastName ?? '';
    final firstName = playerCubit.romanFirstName ?? '';
    // final nid = playerCubit.nid ?? '0000'; // Default if null

    // Take up to 2 characters for names, pad if needed
    final lastNamePart =
        lastName.length >= 2
            ? lastName.substring(0, 2)
            : lastName.padRight(2, 'x');

    final firstNamePart =
        firstName.length >= 2
            ? firstName.substring(0, 2)
            : firstName.padRight(2, 'x');

    // // Get last 4 digits of NID
    // final nidPart =
    //     nid.length >= 4 ? nid.substring(nid.length - 4) : nid.padLeft(4, '0');

    return '$appPrefix$year.${lastNamePart.toLowerCase()}.'
        '${firstNamePart.toLowerCase()}.$datePart@${appName.toLowerCase()}.com';
  }

  void _showError(BuildContext context, String message) {
    CustomSnackbar.showTopSnackBar(context, message: message, isError: true);
  }
}
