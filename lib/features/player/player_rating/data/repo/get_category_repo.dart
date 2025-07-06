import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/category_model.dart';
import '../model/certina_model.dart';

class GetCategoryRepo {
  final GraphQLService _graphQLService = GraphQLService();

  Future<Either<CustomError, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _graphQLService.fetchCollection(
        collection: BackendPoint.category,
        fields: ['id', 'name'],
        fromJson: CategoryModel.fromJson,
      );
      return Right(response);
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }

  Future<Either<CustomError, List<CriteriaModel>>> getCriteria() async {
    try {
      final response = await _graphQLService.fetchCollection(
        collection: BackendPoint.criteria,
        fields: [
          'id',
          '${BackendPoint.category}{id}',
          'name',
          'average',
          'max',
        ],
        fromJson: CriteriaModel.fromJson,
      );
      return Right(response);
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
