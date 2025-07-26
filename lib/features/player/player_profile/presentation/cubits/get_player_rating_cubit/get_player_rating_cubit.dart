import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../data/model/player_rating_model.dart';
import '../../../data/repo/get_player_rating_repo.dart';

part 'get_player_rating_state.dart';

class GetPlayerRatingCubit extends Cubit<GetPlayerRatingState> {
  GetPlayerRatingRepo repo;
  GetPlayerRatingCubit(this.repo) : super(GetPlayerRatingInitial());

  Future<void> getPlayerRating(String playerId) async {
    emit(GetPlayerRatingLoading());
    final rating = await repo.getPlayerRating(playerId);
    rating.fold(
      (error) {
        if (!isClosed) {
          if (error.message == LangKeys.noDataFound) {
            emit(GetPlayerRatingLoadingIsEmpty());
          } else {
            debugPrint('Error fetching player rating: ${error.message}');
            emit(GetPlayerRatingFailure(error.message));
          }
        }
      },
      (data) {
        if (!isClosed) {
          emit(GetPlayerRatingSuccess(data));
        }
      },
    );
  }
}
