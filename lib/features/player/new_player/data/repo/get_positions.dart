import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/position_model.dart';

class GetPositions {
  GraphQLService service;
  GetPositions(this.service);

  Future<Either<CustomError, List<PositionModel>>> getPosition() async {
    try {
      var response = await service.fetchCollection(
        collection: BackendPoint.position,
        fields: ['name', 'code'],
        fromJson: PositionModel.fromJson,
      );
      if (response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      } else {
        return Right(response);
      }
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }
}
