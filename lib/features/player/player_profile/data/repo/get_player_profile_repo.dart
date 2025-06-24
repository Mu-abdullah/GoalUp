import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/player_profile_model.dart';

class GetPlayerProfileRepo {
  final GraphQLService _service;
  GetPlayerProfileRepo(this._service);

  Future<Either<CustomError, PlayerProfileModel>> getPlayerProfile(
    String playerId,
  ) async {
    try {
      var response = await _service.fetchCollection(
        collection: BackendPoint.players,
        fields: [
          'id',
          'name',
          'birthday',
          'contact_number',
          'nid',
          'enrollment_date',
          'nationality{flag}',
          'image',
          'position{code}',
        ],
        fromJson: (PlayerProfileModel.fromJson),
        filters: {
          'id': {'eq': playerId},
        },
        limit: 1,
      );

      return Right(response.first);
    } catch (e) {
      return Left(
        CustomError('Failed to fetch player profile: ${e.toString()}'),
      );
    }
  }
}
