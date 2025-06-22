import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo repo;
  AuthCubit(this.repo) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> login() async {
    emit(AuthLoading());

    final response = await repo.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    response.fold(
      (l) {
        if (!isClosed) {
          debugPrint('Error: $l');
          emit(AuthError(l));
        }
      },
      (r) {
        if (!isClosed) {
          debugPrint('Success: ${r.toString()}');
          emit(AuthSuccess(r));
        }
      },
    );
  }
}
