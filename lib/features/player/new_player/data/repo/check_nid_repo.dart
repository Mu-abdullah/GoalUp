import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sport/core/error/custom_errors.dart';
import 'package:sport/core/services/graph_ql/graph_ql.dart';
import 'package:sport/core/services/supabase/backend_points.dart';

import '../../../../../core/language/lang_keys.dart';
import '../model/new_player_model.dart';

class CheckNidRepo {
  GraphQLService graphQLService;

  CheckNidRepo(this.graphQLService);

  Future<Either<CustomError, NewPlayerModel>> checkNid(String nid) async {
    try {
      final response = await graphQLService.fetchCollection(
        collection: BackendPoint.players,
        fields: [
          'id',
          'name',
          'contact_number',
          'nid',
          'birthday',
          'created_at',
          'enrollment_date',
          'position{code}',
          'nationality{name}',
          'image',
        ],
        fromJson: NewPlayerModel.fromJson,
        filters: {
          'nid': {'eq': nid},
        },
      );
      if (response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      }
      return Right(response.first);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
