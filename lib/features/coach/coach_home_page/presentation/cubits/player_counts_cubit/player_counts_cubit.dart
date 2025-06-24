import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/player_count_model.dart';
import '../../../data/repo/player_count_repo.dart';

part 'player_counts_state.dart';

class PlayerCountsCubit extends Cubit<PlayerCountsState> {
  PlayerCountRepo repo;
  PlayerCountsCubit(this.repo) : super(PlayerCountsInitial());

  Future<void> getPlayerCount(String academyId) async {
    emit(PlayerCountsLoading());
    var result = await repo.getPlayerCount(academyId);
    result.fold(
      (l) {
        if (!isClosed) {
          emit(PlayerCountsError(l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(PlayerCountsLoaded(r));
        }
      },
    );
  }
}
