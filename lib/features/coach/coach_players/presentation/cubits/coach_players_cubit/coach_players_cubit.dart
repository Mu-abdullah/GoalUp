import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repo/get_coach_players.dart';

part 'coach_players_state.dart';

class CoachPlayersCubit extends Cubit<CoachPlayersState> {
  final GetCoachPlayers repo;
  CoachPlayersCubit(this.repo) : super(CoachPlayersInitial());
}
