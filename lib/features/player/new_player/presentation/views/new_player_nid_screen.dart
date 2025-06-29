import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../data/repo/check_nid_repo.dart';
import '../cubits/check_user_nid_cubit/check_user_nid_cubit.dart';
import '../refactor/check_nid_body.dart';

class NewPlayerNidScreen extends StatelessWidget {
  const NewPlayerNidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loc = locator<CheckNidRepo>();
    return BlocProvider(
      create: (context) => CheckUserNidCubit(loc),
      child: Scaffold(
        appBar: CustomAppBar(title: LangKeys.newPlayer),
        body: CheckNidBody(),
      ),
    );
  }
}

