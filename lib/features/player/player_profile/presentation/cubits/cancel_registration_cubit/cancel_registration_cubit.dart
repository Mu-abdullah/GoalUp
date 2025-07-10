import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/add_history.dart';
import '../../../data/repo/cancel_registration_repo.dart';

part 'cancel_registration_state.dart';

class CancelRegistrationCubit extends Cubit<CancelRegistrationState> {
  CancelRegistrationRepo repo;
  CancelRegistrationCubit(this.repo) : super(CancelRegistrationInitial());
  static CancelRegistrationCubit get(context) => BlocProvider.of(context);

  Future<bool> addToPlayerHistory({required Map<String, dynamic> data}) async {
    emit(AddToHistoryLoading());
    final result = await repo.addToHistory(data);
    return result.fold(
      (l) {
        if (!isClosed) emit(AddToHistoryError(l.message));
        return false;
      },
      (r) {
        if (!isClosed) emit(AddToHistoryDone(r));
        return true;
      },
    );
  }

  Future<bool> cancelRegistration(String playerId) async {
    emit(CancelRegistrationLoading());
    final result = await repo.registerCancerRegistration(playerId);
    return result.fold(
      (l) {
        if (!isClosed) emit(CancelRegistrationError(l.message));
        return false;
      },
      (r) {
        if (!isClosed) emit(CancelRegistrationDone());
        return true;
      },
    );
  }
}
