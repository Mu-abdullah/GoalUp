import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/admin_country_model.dart';

class AdminGetCountries {
  GraphQLService service;
  AdminGetCountries(this.service);

  Future<Either<CustomError, List<AdminCountryModel>>> getCountries() async {
    try {
      var response = await service.fetchCollection(
        collection: BackendPoint.nationality,
        fields: ['name', 'flag'],
        fromJson: AdminCountryModel.fromJson,
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
