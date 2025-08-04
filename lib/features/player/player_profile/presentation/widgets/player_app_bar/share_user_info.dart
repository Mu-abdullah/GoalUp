import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sport/core/style/widgets/app_button.dart';

import '../../../../../../core/services/get_it/git_it.dart';
import '../../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/user_info_model.dart';
import '../../../data/repo/user_info_repo.dart';
import '../../cubits/share_info_cubit/share_info_cubit.dart';

class ShareUserInfo extends StatelessWidget {
  const ShareUserInfo({super.key, required this.playerId});
  final String playerId;
  @override
  Widget build(BuildContext context) {
    final lac = locator<UserInfoRepo>();
    return BlocProvider(
      create: (context) => ShareInfoCubit(lac)..shareInfo(playerId),
      child: BlocBuilder<ShareInfoCubit, ShareInfoState>(
        builder: (context, state) {
          if (state is ShareInfoLoading) {
            return LoadingShimmer();
          } else if (state is ShareInfoLoaded) {
            return InfoForm(info: state.playerInfo);
          } else if (state is ShareInfoError) {
            return Center(child: AppText(state.error));
          }
          return LoadingShimmer();
        },
      ),
    );
  }
}

class InfoForm extends StatelessWidget {
  const InfoForm({super.key, required this.info});
  final UserInfoModel info;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(info.playerName!, tr: false, isBold: true),
          AppText(info.playerId!, tr: false),
          AppText(info.email!, tr: false),
          AppButton(
            onTap: () {
              SharePlus.instance.share(
                ShareParams(text: '${info.playerName}\n${info.email}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
