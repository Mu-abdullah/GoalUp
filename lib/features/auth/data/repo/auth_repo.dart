import 'package:dartz/dartz.dart';
import 'package:sport/core/services/shared_pref/pref_keys.dart';
import 'package:sport/core/services/shared_pref/shared_pref.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/custom_errors.dart';
import '../../../../core/services/supabase/auth_service/auth_services.dart';

class AuthRepo {
  final AuthServices _authServices;

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

  //save user data to local storage
  Future<void> saveUserData({required String value}) async {
    SharedPref.saveData(key: PrefKeys.coachId, value: value);
  }
}
