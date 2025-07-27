import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../../../../../core/services/supabase/data_base_services.dart';
import '../model/evaluations_model.dart';

class SaveEvaluationsRepo {
  final DataService service;

  SaveEvaluationsRepo(this.service);

  Future<Either<CustomError, EvaluationsModel>> addEvaluations({
    required Map<String, dynamic> data,
  }) async {
    return await service.addData<EvaluationsModel>(
      table: BackendPoint.rating,
      data: data,
      fromJson: EvaluationsModel.fromJson,
    );
  }
}
