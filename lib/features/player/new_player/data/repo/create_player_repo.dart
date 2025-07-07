import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../../../../../core/services/supabase/data_base_services.dart';
import '../model/create_academy_player.dart';
import '../model/create_new_player.dart';
import '../model/create_user.dart';

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

  Future<Either<CustomError, CreateAcademyPlayer>> createAcademyPlayer(
    CreateAcademyPlayer data,
  ) async {
    var res = await service.addData<CreateAcademyPlayer>(
      table: BackendPoint.academysPlayers,
      fromJson: CreateAcademyPlayer.fromJson,
      data: data.toJson(),
    );

    return res;
  }

  Future<Either<CustomError, CreateUser>> createUser(CreateUser data) async {
    var res = await service.addData<CreateUser>(
      table: BackendPoint.users,
      fromJson: CreateUser.fromJson,
      data: data.toJson(),
    );

    return res;
  }
}
