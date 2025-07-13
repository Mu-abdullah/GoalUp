import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/evaluations_model.dart';
import '../../../data/repo/save_certina_repo.dart';

part 'save_evaluations_state.dart';

class SaveEvaluationsCubit extends Cubit<SaveEvaluationsState> {
  final SaveEvaluationsRepo repo;
  SaveEvaluationsCubit(this.repo) : super(SaveEvaluationsInitial());

  static SaveEvaluationsCubit get(context) => BlocProvider.of(context);

  Future<void> addEvaluations(Map<String, dynamic> data) async {
    emit(SaveEvaluationsLoading());

    final result = await repo.addEvaluations(data: data);
    result.fold(
      (error) {
        if (!isClosed) {
          emit(SaveEvaluationsError(error.message));
        }
      },
      (evaluations) {
        if (!isClosed) {
          emit(SaveEvaluationsLoaded(evaluations: evaluations));
        }
      },
    );
  }
}
