import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/custom_errors.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/services/graph_ql/graph_ql.dart';
import '../../../../core/services/shared_pref/pref_keys.dart';
import '../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../core/services/supabase/auth_service/auth_services.dart';
import '../../../../core/services/supabase/backend_points.dart';
import '../model/user_auth_model.dart';

class AuthRepo {
  final AuthServices _authServices;
  final GraphQLService service = GraphQLService();
  AuthRepo(this._authServices);

  Future<Either<String, AuthResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authServices.signIn(
        email: email,
        password: password,
      );

      final userId = response.user?.id ?? '';

      if (userId.isNotEmpty) {
        return Right(response);
      } else {
        return const Left('فشل تسجيل الدخول: المستخدم غير موجود.');
      }
    } catch (error) {
      final message = AuthExceptionHandler.handle(error);
      return Left(message);
    }
  }

  Future<Either<CustomError, List<UserAuthModel>>> checkUserPlayer({
    required String email,
  }) async {
    try {
      var response = await service.fetchCollection(
        collection: BackendPoint.users,
        fields: ['id', 'player_id'],
        fromJson: UserAuthModel.fromJson,
        filters: {
          'email': {'eq': email},
        },
        limit: 1
      );
      if (response.isEmpty) {
        return left(CustomError(LangKeys.userNotFound));
      } else {
        return right(response);
      }
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
      return left(CustomError(LangKeys.somethingWentWrong));
    }
  }

  //save user data to local storage
  Future<void> saveUserData({required String value}) async {
    SharedPref.saveData(key: PrefKeys.coachId, value: value);
  }
}
