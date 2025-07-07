import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../cubits/coach_profile_cubit/coach_profile_cubit.dart';
import 'coach_info.dart';

class CoachIfoWidget extends StatelessWidget {
  const CoachIfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachProfileCubit, CoachProfileState>(
      builder: (context, state) {
        if (state is CoachProfileLoading) {
          return LoadingShimmer(height: 100);
        } else if (state is CoachProfileLoaded) {
          var coach = state.coach;
          return CoachInfo(coach: coach);
        } else if (state is CoachProfileError) {
          return AppText(state.message);
        } else {
          return Container();
        }
      },
    );
  }
}
