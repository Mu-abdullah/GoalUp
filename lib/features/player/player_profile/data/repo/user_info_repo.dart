import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/user_info_model.dart';

class UserInfoRepo {
  final GraphQLService s;
  UserInfoRepo(this.s);

  Future<Either<CustomError, UserInfoModel>> getUserInfo(playerId) async {
    try {
      var response = await s.fetchCollection(
        collection: BackendPoint.users,
        fields: ['id', 'created_at', 'email', 'players{id name}'],
        fromJson: UserInfoModel.fromJson,
        filters: {
          'player_id': {'eq': playerId},
        },
      );
      return Right(response.first);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
