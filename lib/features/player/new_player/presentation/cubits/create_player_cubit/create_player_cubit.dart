import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/create_academy_player.dart';
import '../../../data/model/create_new_player.dart';
import '../../../data/model/create_user.dart';
import '../../../data/repo/create_player_repo.dart';

part 'create_player_state.dart';

class CreatePlayerCubit extends Cubit<CreatePlayerState> {
  final CreatePlayerRepo repo;

  CreatePlayerCubit(this.repo, {this.isEdit = false})
    : super(CreatePlayerInitial());

  static CreatePlayerCubit get(context) => BlocProvider.of(context);
  bool isEdit;
  Future<void> createPlayer({
    required Map<String, dynamic> player,
    required CreateAcademyPlayer academyPlayer,
    required CreateUser user,
  }) async {
    emit(CreatePlayerLoading());
    final result = await repo.createPlayer(player);
    result.fold(
      (error) {
        if (!isClosed) {
          debugPrint('Error creating player: ${error.message}');
          emit(CreatePlayerError(error.message));
        }
      },
      (player) async {
        if (!isClosed) {
          await createAcademyPlayer(academyPlayer);
          await createUser(user);
          emit(CreatePlayerLoaded(player));
        }
      },
    );
  }

  Future<void> createAcademyPlayer(CreateAcademyPlayer player) async {
    await repo.createAcademyPlayer(player);
  }

  Future<void> createUser(CreateUser user) async {
    await repo.createUser(user);
  }
}
