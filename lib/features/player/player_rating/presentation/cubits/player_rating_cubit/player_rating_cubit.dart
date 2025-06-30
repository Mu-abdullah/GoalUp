import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/registration_forms/dr_personal_info.dart';
import '../../widgets/registration_forms/professional_info.dart';

part 'player_rating_state.dart';

class PlayerRatingCubit extends Cubit<PlayerRatingState> {
  PlayerRatingCubit() : super(PlayerRatingState.initial());

  static PlayerRatingCubit get(context) => BlocProvider.of(context);

  final PageController controller = PageController();

  final List<Widget> pages = [
    DrPersonalInformation(),
    ProfessionalInformation(),
  ];

  void goToPage(int index) {
    if (index >= 0 && index < pages.length) {
      emit(state.copyWith(currentPage: index));
    }
  }

  void nextPage() {
    final nextIndex = state.currentPage + 1;
    if (nextIndex < pages.length) {
      emit(state.copyWith(currentPage: nextIndex));
    }
  }

  void previousPage() {
    final prevIndex = state.currentPage - 1;
    if (prevIndex >= 0) {
      emit(state.copyWith(currentPage: prevIndex));
    }
  }
}
