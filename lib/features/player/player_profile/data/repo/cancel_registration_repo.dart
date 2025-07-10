import 'package:dartz/dartz.dart';

import '../../../../../core/error/custom_errors.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../../../../../core/services/supabase/data_base_services.dart';
import '../model/add_history.dart';

class CancelRegistrationRepo {
  DataService service;

  CancelRegistrationRepo(this.service);

  Future<Either<CustomError, bool>> registerCancerRegistration(
    String playerId,
  ) async {
    try {
      await service.delete(table: BackendPoint.academysPlayers, id: playerId);

      return Right(true);
    } catch (e) {
      return Left(CustomError(LangKeys.somethingWentWrong));
    }
  }

  Future<Either<CustomError, AddHistoryModel>> addToHistory(
    Map<String, dynamic> data,
  ) async {
    return await service.addData<AddHistoryModel>(
      table: BackendPoint.playerHistory,
      data: data,
      fromJson: AddHistoryModel.fromJson,
    );
  }
}
