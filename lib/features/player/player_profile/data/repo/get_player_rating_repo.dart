import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/error/custom_errors.dart';
import '../model/player_rating_model.dart';

class GetPlayerRatingRepo {
  Future<Either<CustomError, List<PlayerRatingModel>>> getPlayerRating(
    String playerId,
  ) async {
    try {
      final response = await Supabase.instance.client
          .from('rating')
          .select('''
          id,
          created_at,
          player_score,
          player,
          criteria(id, name,max, category(id, name)),
          evaluation_day
        ''')
          .eq('player', playerId);

      final data = response as List<dynamic>;
      final result =
          data.map((json) => PlayerRatingModel.fromJson(json)).toList();

      if (result.isEmpty) {
        return Left(CustomError('لا توجد تقييمات'));
      }

      return Right(result);
    } catch (e) {
      return Left(CustomError('خطأ في تحميل التقييمات: $e'));
    }
  }
}
