import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../cubits/coach_home_cubit/coach_home_cubit.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  State<CoachHomePage> createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  late String empID;

  @override
  void initState() {
    super.initState();

    empID = context.read<AppUserCubit>().coachId;
    debugPrint('Coach ID: $empID');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoachHomeCubit(),
      child: Column(children: [
           
        ],
      ),
    );
  }
}
