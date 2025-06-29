import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../model/country_model.dart';

class GetCountries {
  GraphQLService service;
  GetCountries(this.service);

  Future<Either<CustomError, List<CountryModel>>> getCountries() async {
    try {
      var response = await service.fetchCollection(
        collection: BackendPoint.nationality,
        fields: ['name', 'flag'],
        fromJson: CountryModel.fromJson,
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
