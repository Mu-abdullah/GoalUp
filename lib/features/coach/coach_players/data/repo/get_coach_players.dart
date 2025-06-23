import 'package:dartz/dartz.dart';
import 'package:sport/core/services/supabase/backend_points.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../model/get_players_model.dart';

class GetCoachPlayers {
  final GraphQLService _service;
  GetCoachPlayers(this._service);

  Future<Either<CustomError, List<GetPlayersModel>>> getCoachPlayers({
    required String academyId,
  }) async {
    try {
      final response = await _service.fetchCollection(
        collection: BackendPoint.players,
        filters: {
          'academy': {'eq': academyId},
        },
        fields: ['id', 'name', 'image', 'birthday', 'position{code}'],
        fromJson: (GetPlayersModel.fromJson),
      );

      return Right(response);
    } catch (error) {
      return Left(CustomError(error.toString()));
    }
  }
}
