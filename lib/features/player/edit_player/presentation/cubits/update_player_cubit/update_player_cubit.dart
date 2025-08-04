import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../new_player/data/model/create_new_player.dart';
import '../../../../new_player/data/repo/update_player_repo.dart';

part 'update_player_state.dart';

class UpdatePlayerCubit extends Cubit<UpdatePlayerState> {
  final UpdatePlayerRepo repo;
  UpdatePlayerCubit({required this.repo}) : super(UpdatePlayerInitial());
  static UpdatePlayerCubit get(context) => BlocProvider.of(context);
  Future<void> updatePlayer(CreateNewPlayer player) async {
    emit(UpdatePlayerLoading());

    final result = await repo.updatePlayer(player);
    result.fold(
      (failure) {
        if (!isClosed) {
          debugPrint('Error updating player: ${failure.message}');
          emit(UpdatePlayerFailure(failure.message));
        }
      },
      (success) {
        if (!isClosed) {
          emit(UpdatePlayerSuccess());
        }
      },
    );
  }
}
