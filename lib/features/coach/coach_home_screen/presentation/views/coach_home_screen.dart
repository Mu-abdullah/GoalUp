import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import '../refactor/bottom_bar_body.dart';

class CoachHomeScreen extends StatelessWidget {
  const CoachHomeScreen({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => BottomBarCubit(isAdmin))],
      child: BottomBarBody(),
    );
  }
}
