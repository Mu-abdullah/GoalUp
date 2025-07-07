import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/coach_model.dart';

class GetCoachInfoRepo {
  GraphQLService service;

  GetCoachInfoRepo(this.service);

  Future<Either<CustomError, CoachModel>> getInfo() async {
    try {
      var response = await service.fetchCollection(
        collection: BackendPoint.coaches,
        fields: [
          'id',
          'name',
          'email',
          'phone_number',
          'academy{name}',
          'academy{logo}',
          'nationality{flag}',
          'qualifications',
          'image',
        ],
        fromJson: CoachModel.fromJson,
        filters: {
          'uid': {'eq': service.supabase.auth.currentUser!.id},
        },
      );
      if (response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      } else {
        return Right(response.first);
      }
    } catch (e) {
      debugPrint(e.toString());
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
