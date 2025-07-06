import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/create_new_player.dart';
import '../../../data/repo/create_player_repo.dart';

part 'create_player_state.dart';

class CreatePlayerCubit extends Cubit<CreatePlayerState> {
  final CreatePlayerRepo repo;

  CreatePlayerCubit(this.repo) : super(CreatePlayerInitial());

  static CreatePlayerCubit get(context) => BlocProvider.of(context);

  Future<void> createPlayer(Map<String, dynamic> player) async {
    emit(CreatePlayerLoading());
    final result = await repo.createPlayer(player);
    result.fold(
      (error) {
        if (!isClosed) {
          debugPrint('Error creating player: ${error.message}');
          emit(CreatePlayerError(error.message));
        }
      },
      (player) {
        if (!isClosed) {
          emit(CreatePlayerLoaded(player));
        }
      },
    );
  }
}
