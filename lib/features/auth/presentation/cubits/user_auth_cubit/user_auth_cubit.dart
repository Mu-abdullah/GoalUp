import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/language/lang_keys.dart';

import '../../../data/model/user_auth_model.dart';
import '../../../data/repo/auth_repo.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  AuthRepo repo;
  UserAuthCubit(this.repo) : super(UserAuthInitial());
  static UserAuthCubit get(context) => BlocProvider.of<UserAuthCubit>(context);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  Future<void> checkIfRowExists() async {
    emit(CheckUserLoading());
    var result = await repo.checkUserPlayer(email: emailController.text);
    result.fold(
      (l) {
        if (!isClosed) {
          if (l.message == LangKeys.userNotFound) {
            emit(UserNotExists());
          } else {
            emit(CheckUserError(l.message));
          }
        }
      },
      (r) {
        if (!isClosed) {
          emit(UserExists(r.first));
        }
      },
    );
  }
}
