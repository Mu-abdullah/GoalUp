import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/functions/generate_id.dart';
import '../../../../../../core/services/supabase/backend_points.dart';
import '../../../data/model/new_player_model.dart';

part 'new_player_state.dart';

class NewPlayerCubit extends Cubit<NewPlayerState> {
  NewPlayerCubit(
    BuildContext context, {
    this.nid,
    this.player,
    required this.count,
  }) : super(NewPlayerInitial()) {
    init(context);
  }
  static NewPlayerCubit get(context) => BlocProvider.of(context);
  final NewPlayerModel? player;
  final String? nid;
  final int count;

  late String? national;

  var formKey = GlobalKey<FormState>();
  var id = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var nidController = TextEditingController();
  var academy = TextEditingController();
  var birth = TextEditingController();
  var enroll = TextEditingController();

  /// [nationality, position, ]
  init(BuildContext context) {
    id = TextEditingController(
      text:
          player?.id ??
          GenerateId.generateDocumentId(
            context: context,
            table: BackendPoint.players,
            format: 'yyMMdd',
            count: count + 1,
          ),
    );
    academy = TextEditingController(text: AppUserCubit.get(context).academyId);
    name = TextEditingController(text: player?.name ?? '');
    phone = TextEditingController(text: player?.contactNumber ?? '');
    nidController = TextEditingController(text: player?.nid ?? nid);
    birth = TextEditingController(text: player?.birthday ?? '');
    enroll = TextEditingController(text: player?.enrollmentDate ?? '');
  }
}
