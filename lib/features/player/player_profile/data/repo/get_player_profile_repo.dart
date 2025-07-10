import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/player_profile_model.dart';

class GetPlayerProfileRepo {
  final GraphQLService _service;
  GetPlayerProfileRepo(this._service);

  Future<Either<CustomError, List<PlayerProfileModel>>> init(
    String playerId,
  ) async {
    try {
      // First try academy profile
      final academyResult = await getPlayerAcademyProfile(playerId);

      // Check if academy has actual data (not just successful response)
      final academyData = academyResult.fold(
        (error) => <PlayerProfileModel>[], // Empty list if error
        (data) => data, // Return the data
      );

      if (academyData.isNotEmpty) {
        return Right(academyData);
      }

      final playerResult = await getPlayerProfile(playerId);

      return playerResult.fold((error) => Left(error), (data) {
        if (data.isEmpty) {
          return Left(CustomError(LangKeys.userNotFound));
        }

        return Right(data);
      });
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }

  Future<Either<CustomError, List<PlayerProfileModel>>> getPlayerAcademyProfile(
    String playerId,
  ) async {
    try {
      var response = await _service.fetchCollection(
        collection: BackendPoint.academysPlayers,
        filters: {
          'player': {'eq': playerId},
        },
        fields: [
          'id ${BackendPoint.players}{id name birthday contact_number nid nationality{flag} image position{code}}',
          '${BackendPoint.academy}{name} enrollment_date',
        ],
        fromJson: (PlayerProfileModel.fromAnotherTableJson),
        limit: 1,
      );

      return Right(response);
    } catch (e) {
      return Left(
        CustomError('Failed to fetch player profile: ${e.toString()}'),
      );
    }
  }

  Future<Either<CustomError, List<PlayerProfileModel>>> getPlayerProfile(
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
      debugPrint("response length  ${response.length}");
      debugPrint("response data  ${response.first.toJson()}");
      return Right(response);
    } catch (e) {
      return Left(
        CustomError('Failed to fetch player profile: ${e.toString()}'),
      );
    }
  }
}
