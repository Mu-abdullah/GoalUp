import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/player_history_model.dart';

class PlayerHistoryRepo {
  final GraphQLService _service;

  PlayerHistoryRepo(this._service);

  Future<Either<CustomError, List<PlayerHistoryModel>>> getHistory({
    required String playerId,
  }) async {
    try {
      var response = await _service.fetchCollection(
        collection: BackendPoint.playerHistory,
        fields: ['id', 'academy{logo name}', 'from', 'to'],
        fromJson: PlayerHistoryModel.fromJson,
        filters: {
          'player_id': {'eq': playerId},
        },
      );
      if (response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      } else {
        return Right(response);
      }
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
