import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../new_player/data/model/create_academy_player.dart';
import '../../../../new_player/data/repo/create_player_repo.dart';

part 'register_new_player_state.dart';

class RegisterNewPlayerCubit extends Cubit<RegisterNewPlayerState> {
  CreatePlayerRepo repo;
  RegisterNewPlayerCubit(this.repo) : super(RegisterNewPlayerInitial());
  static RegisterNewPlayerCubit get(context) => BlocProvider.of(context);
  Future<void> registerPlayer(CreateAcademyPlayer player) async {
    if (isClosed) return; // Add guard clause

    emit(RegisterNewPlayerLoading());
    final result = await repo.createAcademyPlayer(player);

    if (isClosed) return;

    result.fold(
      (error) => emit(RegisterNewPlayerError(error.message)),
      (data) => emit(RegisterNewPlayerDone(data)),
    );
  }
}
