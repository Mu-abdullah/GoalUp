import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_player_state.dart';

class NewPlayerCubit extends Cubit<NewPlayerState> {
  NewPlayerCubit() : super(NewPlayerInitial());

  static NewPlayerCubit get(context) => BlocProvider.of(context);

  var name = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
}
