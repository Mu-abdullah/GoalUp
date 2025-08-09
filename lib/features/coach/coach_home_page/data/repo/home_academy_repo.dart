import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/home_academy_model.dart';

class HomeAcademyRepo {
  final GraphQLService _service;

  HomeAcademyRepo(this._service);

  Future<Either<CustomError, HomeAcademyModel>> getAcademy(String id) async {
    try {
      var response = await _service.fetchCollection(
        collection: BackendPoint.academy,
        fields: ['logo', 'name', 'active_to', 'subscription_status'],
        fromJson: HomeAcademyModel.fromJson,
        filters: {
          'id': {'eq': id},
        },
      );
      if (response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      } else {
        return Right(response.first);
      }
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
