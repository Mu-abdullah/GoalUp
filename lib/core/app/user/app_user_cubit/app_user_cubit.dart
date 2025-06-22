import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/shared_pref/pref_keys.dart';
import '../../../services/shared_pref/shared_pref.dart';
import '../repo/app_user_repo.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final AppUserRepo repo = AppUserRepo();
  AppUserCubit() : super(UserInitial());

  static AppUserCubit get(context) => BlocProvider.of(context);

  String get coachId => SharedPref.getData(key: PrefKeys.coachId);

  Future<void> logout() async {
    // repo.logout();
    emit(UserLoggedOut());
  }
}
