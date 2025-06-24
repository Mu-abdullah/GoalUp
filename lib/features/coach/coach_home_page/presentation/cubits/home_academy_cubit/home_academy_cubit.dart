import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/home_academy_model.dart';
import '../../../data/repo/home_academy_repo.dart';

part 'home_academy_state.dart';

class HomeAcademyCubit extends Cubit<HomeAcademyState> {
  HomeAcademyRepo repo;
  HomeAcademyCubit(this.repo) : super(CoachHomeInitial());

  Future<void> getAcademy(String id) async {
    emit(HomeAcademyLoading());
    var response = await repo.getAcademy(id);
    response.fold(
      (l) {
        if (!isClosed) {
          emit(HomeAcademError(l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(HomeAcademyLoaded(r));
        }
      },
    );
  }
}
