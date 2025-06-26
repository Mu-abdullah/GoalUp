import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it/git_it.dart';
import '../../data/repo/auth_repo.dart';
import '../cubits/user_auth_cubit/user_auth_cubit.dart';
import '../refactor/user_auth_body.dart';

class UserAuthScreen extends StatelessWidget {
  const UserAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loc = locator<AuthRepo>();
    return BlocProvider(
      create: (context) => UserAuthCubit(loc),
      child: Scaffold(body: UserAuthScreenBody()),
    );
  }
}
