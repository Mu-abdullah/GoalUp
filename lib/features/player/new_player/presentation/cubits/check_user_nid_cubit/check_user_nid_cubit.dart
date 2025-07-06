import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../data/model/new_player_model.dart';
import '../../../data/repo/check_nid_repo.dart';

part 'check_user_nid_state.dart';

class CheckUserNidCubit extends Cubit<CheckUserNidState> {
  CheckNidRepo repo;
  CheckUserNidCubit(this.repo) : super(CheckUserNidInitial());

  static CheckUserNidCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var nidController = TextEditingController();

  Future<void> checkNid(String nid) async {
    emit(CheckUserNidLoading());
    final response = await repo.checkNid(nid);
    response.fold(
      (l) {
        if (!isClosed) {
          if (l.message == LangKeys.noDataFound) {
            emit(CheckUserNidEmpty(LangKeys.noDataFound));
          } else {
            emit(CheckUserNidError(l.message));
          }
        }
      },
      (r) {
        if (!isClosed) {
          emit(CheckUserNidLoaded(r));
        }
      },
    );
  }
}
