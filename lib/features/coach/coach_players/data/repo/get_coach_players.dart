import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/get_players_model.dart';

class GetCoachPlayers {
  final GraphQLService _service;
  GetCoachPlayers(this._service);

  Future<Either<CustomError, List<GetPlayersModel>>> getCoachPlayers({
    required String academyId,
  }) async {
    try {
      final response = await _service.fetchCollection(
        collection: BackendPoint.academysPlayers,
        filters: {
          'academy': {'eq': academyId},
        },
        fields: [
          '${BackendPoint.players}{id name image position{code} nationality{flag} birthday}',
          '${BackendPoint.academy}{name} enrollment_date',
        ],
        fromJson: (GetPlayersModel.fromJson),
      );

      return Right(response);
    } catch (error) {
      return Left(CustomError(error.toString()));
    }
  }
}
