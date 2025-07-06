import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../../../../../core/services/supabase/data_base_services.dart';
import '../model/create_new_player.dart';

class CreatePlayerRepo {
  DataService service;
  CreatePlayerRepo(this.service);

  Future<Either<CustomError, CreateNewPlayer>> createPlayer(
    Map<String, dynamic> data,
  ) async {
    var res = await service.addData<CreateNewPlayer>(
      table: BackendPoint.players,
      fromJson: CreateNewPlayer.fromJson,
      data: data,
    );

    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
