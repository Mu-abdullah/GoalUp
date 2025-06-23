import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/get_players_model.dart';
import '../../../data/repo/get_coach_players.dart';

part 'coach_players_state.dart';

class CoachPlayersCubit extends Cubit<CoachPlayersState> {
  final GetCoachPlayers repo;
  CoachPlayersCubit(this.repo) : super(CoachPlayersInitial());

  Future<void> getCoachPlayers({required String academyId}) async {
    emit(CoachPlayersLoading());
    var result = await repo.getCoachPlayers(academyId: academyId);

    result.fold(
      (l) {
        if (!isClosed) {
          emit(CoachPlayersError(message: l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(CoachPlayersLoaded(players: r));
        }
      },
    );
  }
}
