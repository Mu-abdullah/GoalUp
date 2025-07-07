import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/coach_model.dart';
import '../../../data/repo/get_coach_info_repo.dart';

part 'coach_profile_state.dart';

class CoachProfileCubit extends Cubit<CoachProfileState> {
  GetCoachInfoRepo repo;
  CoachProfileCubit(this.repo) : super(CoachProfileInitial());

  Future<void> getInfo() async {
    emit(CoachProfileLoading());
    var result = await repo.getInfo();
    result.fold(
      (l) {
        if (!isClosed) {
          emit(CoachProfileError(l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(CoachProfileLoaded(r));
        }
      },
    );
  }
}
