import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/custom_errors.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../core/services/shared_pref/pref_keys.dart';
import '../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../core/services/supabase/backend_points.dart';
import '../model/check_coach_model.dart';

class CheckRoleRepo {
  GraphQLService service;
  CheckRoleRepo(this.service);

  Future<Either<CustomError, CheckCoachModel>> getCoach({
    required String uid,
  }) async {
    try {
      final response = await service.fetchCollection<CheckCoachModel>(
        collection: BackendPoint.coaches,
        fields: const ['name', 'academy{id}'],
        fromJson: CheckCoachModel.fromJson,
        filters: {
          'uid': {'eq': uid},
        },
      );
      if (response.isEmpty) {
        return left(CustomError(LangKeys.userNotFound));
      } else {
        saveAcademyId(response.first.academy!);
        return right(response.first);
      }
    } on DioException catch (e) {
      debugPrint('DioException: ${e.toString()}');
      return left(CustomError(LangKeys.somethingWentWrong));
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
      return left(CustomError(LangKeys.somethingWentWrong));
    }
  }

  saveAcademyId(String value) {
    SharedPref.saveData(key: PrefKeys.academyId, value: value);
  }
}
