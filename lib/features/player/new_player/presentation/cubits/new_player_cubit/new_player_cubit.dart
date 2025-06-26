import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/app/user/app_user_cubit/app_user_cubit.dart';

part 'new_player_state.dart';

class NewPlayerCubit extends Cubit<NewPlayerState> {
  NewPlayerCubit(BuildContext context) : super(NewPlayerInitial()) {
    init(context);
  }

  static NewPlayerCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var phone = TextEditingController();
  var nid = TextEditingController();
  var academy = TextEditingController();
  var birth = TextEditingController();
  var enroll = TextEditingController();

  /// [nationality, position, ]
  init(BuildContext context) {
    academy = TextEditingController(text: AppUserCubit.get(context).academyId);
  }
}
