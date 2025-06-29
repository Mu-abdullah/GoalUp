import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/player_count_model.dart';
import '../../../data/repo/player_count_repo.dart';

part 'player_counts_state.dart';

class PlayerCountsCubit extends Cubit<PlayerCountsState> {
  PlayerCountRepo repo;
  PlayerCountsCubit(this.repo) : super(PlayerCountsInitial());
  static PlayerCountsCubit get(context) => BlocProvider.of(context);
  int count = 0;
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
          count = r.length;
          debugPrint('count $count');
          emit(PlayerCountsLoaded(r));
        }
      },
    );
  }
}
