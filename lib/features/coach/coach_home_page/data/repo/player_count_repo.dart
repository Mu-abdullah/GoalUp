import 'package:dartz/dartz.dart';
import 'package:sport/core/error/custom_errors.dart';
import 'package:sport/core/services/graph_ql/graph_ql.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/player_count_model.dart';

class PlayerCountRepo {
  GraphQLService service;

  PlayerCountRepo(this.service);

  Future<Either<CustomError, List<PlayerCountModel>>> getPlayerCount(
    String academyId,
  ) async {
    try {
      var response = await service.fetchCollection(
        collection: BackendPoint.academysPlayers,
        fields: ['id'],
        filters: {
          'academy': {'eq': academyId},
        },
        fromJson: PlayerCountModel.fromJson,
      );

      return Right(response);
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
