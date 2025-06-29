import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/services/get_it/git_it.dart';
import 'package:sport/core/style/custom_widgets/custom_snack_bar.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../data/repo/check_role_repo.dart';
import '../cubits/check_role_cubit/check_role_cubit.dart';

class CheckRole extends StatelessWidget {
  const CheckRole({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    var lac = locator<CheckRoleRepo>();

    return BlocProvider(
      create: (context) => CheckRoleCubit(lac)..checkRole(uid: uid),
      child: Scaffold(
        body: BlocConsumer<CheckRoleCubit, CheckRoleState>(
          listener: (context, state) {
            if (state is CheckRoleError) {
              context.pushNamedAndRemoveUntil(RoutesNames.auth);
              CustomSnackbar.showTopSnackBar(
                context,
                message: state.message,
                isError: true,
              );
            }
            if (state is CheckRoleLoaded) {
              Navigator.pop(context);
              context.pushNamedAndRemoveUntil(RoutesNames.coachHome);
            }
          },
          builder: (context, state) {
            return ListLoadingShimmer();
          },
        ),
      ),
    );
  }
}
