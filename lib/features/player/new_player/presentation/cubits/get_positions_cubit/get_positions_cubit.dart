import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/position_model.dart';
import '../../../data/repo/get_positions.dart';

part 'get_positions_state.dart';

class GetPositionsCubit extends Cubit<GetPositionsState> {
  GetPositions repo;
  GetPositionsCubit(this.repo) : super(GetPositionsInitial());
  static GetPositionsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchPositions() async {
    emit(GetPositionsLoading());
    var response = await repo.getPosition();
    response.fold(
      (l) {
        if (!isClosed) {
          emit(GetPositionsError(l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(GetPositionsLoaded(r));
        }
      },
    );
  }
}
