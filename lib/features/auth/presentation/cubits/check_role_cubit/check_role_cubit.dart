import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repo/check_role_repo.dart';

part 'check_role_state.dart';

class CheckRoleCubit extends Cubit<CheckRoleState> {
  CheckRoleRepo repo;
  CheckRoleCubit(this.repo) : super(CheckRoleInitial());

  Future<void> checkRole({required String uid}) async {
    var result = await repo.getCoach(uid: uid);

    result.fold(
      (l) {
        if (!isClosed) {
          emit(CheckRoleError(message: l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(CheckRoleLoaded());
        }
      },
    );
  }
}
