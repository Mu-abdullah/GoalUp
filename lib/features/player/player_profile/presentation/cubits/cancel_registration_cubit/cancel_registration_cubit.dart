import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/cancer_registration_repo.dart';

part 'cancel_registration_state.dart';

class CancelRegistrationCubit extends Cubit<CancelRegistrationState> {
  CancerRegistrationRepo repo;
  CancelRegistrationCubit(this.repo) : super(CancelRegistrationInitial());
  static CancelRegistrationCubit get(context) => BlocProvider.of(context);

  Future<void> cancelRegistration(playerId) async {
    emit(CancelRegistrationLoading());
    final result = await repo.registerCancerRegistration(playerId);
    result.fold(
      (l) {
        if (!isClosed) {
          emit(CancelRegistrationError(l.message));
        }
      },
      (r) {
        if (!isClosed) {
          debugPrint('Cancel registration: $r');
          emit(CancelRegistrationDone(r));
        }
      },
    );
  }
}
