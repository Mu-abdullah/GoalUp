import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_info_model.dart';
import '../../../data/repo/user_info_repo.dart';

part 'share_info_state.dart';

class ShareInfoCubit extends Cubit<ShareInfoState> {
  UserInfoRepo repo;
  ShareInfoCubit(this.repo) : super(ShareInfoInitial());
  static ShareInfoCubit get(context) => BlocProvider.of(context);
  Future<void> shareInfo(String playerId) async {
    emit(ShareInfoLoading());
    var result = await repo.getUserInfo(playerId);
    result.fold(
      (l) {
        if (!isClosed) {
          emit(ShareInfoError(l.message));
        }
      },
      (r) {
        if (!isClosed) {
          emit(ShareInfoLoaded(r));
        }
      },
    );
  }
}
