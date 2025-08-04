import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../player_profile/data/model/player_profile_model.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final PlayerProfileModel player;
  UpdateCubit({required this.player}) : super(UpdateInitial());
  static UpdateCubit get(context) => BlocProvider.of<UpdateCubit>(context);
}
