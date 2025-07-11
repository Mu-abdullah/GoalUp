import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/language/lang_keys.dart';

import '../../../data/model/player_history_model.dart';
import '../../../data/repo/player_history_repo.dart';

part 'player_history_state.dart';

class PlayerHistoryCubit extends Cubit<PlayerHistoryState> {
  final PlayerHistoryRepo repo;
  PlayerHistoryCubit(this.repo) : super(PlayerHistoryInitial());

  static PlayerHistoryCubit get(context) => BlocProvider.of(context);

  Future<void> getPlayerHistory(String playerId) async {
    emit(PlayerHistoryLoading());
    var res = await repo.getHistory(playerId: playerId);
    res.fold(
      (l) {
        if (!isClosed) {
          if (l.message == LangKeys.noDataFound) {
            emit(PlayerNoHistoryFound());
          } else {
            emit(PlayerHistoryError(l.message));
          }
        }
      },
      (r) {
        if (!isClosed) {
          emit(PlayerHistoryLoaded(r));
        }
      },
    );
  }
}
