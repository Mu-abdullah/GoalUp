import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/player_rating_model.dart';

class GetPlayerRatingRepo {
  final GraphQLService service;

  GetPlayerRatingRepo(this.service);

  Future<Either<CustomError, List<PlayerRatingModel>>> getPlayerRating(
    String playerId,
  ) async {
    try {
      var result = await service.fetchCollection(
        collection: BackendPoint.evaluations,
        fields: [
          'id',
          'created_at',
          'player_score',
          '''
          criteria {
            id
            name
            category {
              id
              name
            }
          }
          ''',
          'player',
        ],
        fromJson: (json) => PlayerRatingModel.fromJson(json),
        filters: {
          'player': {'eq': playerId},
        },
      );

      if (result.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      } else {
        return Right(result);
      }
    } catch (e) {
      debugPrint('Error fetching player rating: ${e.toString()}');
      return Left(CustomError(e.toString()));
    }
  }
}
