import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../player_profile/data/model/player_profile_model.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final PlayerProfileModel player;
  UpdateCubit({required this.player}) : super(UpdateInitial()) {
    init();
  }
  static UpdateCubit get(context) => BlocProvider.of<UpdateCubit>(context);

  var id = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var nidController = TextEditingController();
  var academy = TextEditingController();
  var birth = TextEditingController();
  String? position;
  init() {
    id.text = player.id ?? '';
    name.text = player.name ?? '';
    phone.text = player.contactNumber ?? '';
    nidController.text = player.nid ?? '';
    academy.text = player.academy ?? '';
    birth.text = player.birthday ?? '';
  }
}
