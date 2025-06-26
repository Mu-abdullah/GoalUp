import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/shared_pref/pref_keys.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';

part 'remmber_me_state.dart';

class RemmberMeCubit extends Cubit<RemmberMeState> {
  RemmberMeCubit() : super(RemmberMeInitial());
  static RemmberMeCubit get(context) =>
      BlocProvider.of<RemmberMeCubit>(context);
  bool isRemmber = false;
  Future<void> remmeberMe() async {
    await SharedPref.saveData(key: PrefKeys.remember, value: true);
  }

  void saveMe() {
    if (isRemmber == true) {
      remmeberMe();
    }
  }
}
