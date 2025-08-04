import 'package:dartz/dartz.dart';
import 'package:sport/core/error/custom_errors.dart';
import 'package:sport/core/services/graph_ql/graph_ql.dart';
import 'package:sport/core/services/supabase/backend_points.dart';

import '../model/create_new_player.dart';

class UpdatePlayerRepo {
  final GraphQLService service;
  UpdatePlayerRepo(this.service);
  Future<Either<CustomError, CreateNewPlayer>> updatePlayer(
    CreateNewPlayer player,
  ) async {
    try {
      var response = await service.updateCollection(
        collection: BackendPoint.players,
        updates: player.toJson(),
        filter: {
          'id': {'eq': player.id},
        },
        fromJson: CreateNewPlayer.fromJson,
        returningFields: const ['id', 'name', 'image'],
      );
      return Right(response.first);
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
