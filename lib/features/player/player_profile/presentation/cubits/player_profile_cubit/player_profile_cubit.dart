import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/get_player_profile_repo.dart';

part 'player_profile_state.dart';

class PlayerProfileCubit extends Cubit<PlayerProfileState> {
  GetPlayerProfileRepo repo;
  PlayerProfileCubit(this.repo, {this.isAdmin = false})
    : super(PlayerProfileInitial());

  static PlayerProfileCubit get(context) => BlocProvider.of(context);

  bool isAdmin;
  bool showStats = false;

  var isAcademyPlayer = false;

  Future<void> getPlayerProfileById(String playerId) async {
    final result = await repo.init(playerId);
    result.fold(
      (error) {
        if (!isClosed) {
          debugPrint('Error fetching player profile: ${error.message}');
          emit(PlayerProfileError(error.message));
        }
      },
      (data) {
        if (!isClosed) {
         
          emit(PlayerProfileLoaded(data.first));
        }
      },
    );
  }

  void toggleStats() {
    showStats = !showStats;
    emit(ShowStats(showStats));
  }
}
