import 'package:dartz/dartz.dart';

import '../../error/custom_errors.dart';
import '../../language/lang_keys.dart';
import 'supabase_services_repo.dart';

abstract class DataService {
  Future<Either<CustomError, List<T>>> getListOfData<T>(
    String table,
    T Function(Map<String, dynamic>) fromJson, {
    int? limit,
    String? searchKey,
    String? filterKey,
    dynamic value,
    String? orderBy,
    bool? ascending,
  });

  Future<Either<CustomError, T>> getData<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJson,
    required String? filterKey,
    required dynamic value,
  });

  Future<Either<CustomError, T>> addData<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> data,
  });

  Future<bool> checkIfRowExists({
    required String table,
    required Map<String, dynamic> data,
  });

  Future<void> update({
    required String table,
    required int id,
    required Map<String, dynamic> data,
  });

  Future<void> delete({required String table, required int id});
}

class SupabaseDataService implements DataService {
  final SupabaseServicesRepo supabaseService;

  SupabaseDataService(this.supabaseService);

  @override
  Future<Either<CustomError, List<T>>> getListOfData<T>(
    String table,
    T Function(Map<String, dynamic>) fromJson, {
    int? limit,
    String? searchKey,
    String? filterKey,
    dynamic value,
    String? orderBy,
    bool? ascending,
  }) async {
    try {
      final response = await supabaseService.getData(
        table: table,
        limit: limit,
        filterKey: filterKey,
        value: value,
        searchKey: searchKey,
        orderBy: orderBy,
        ascending: ascending,
      );

      if (response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      }
      if (response == null) {
        return Left(CustomError(LangKeys.somethingWentWrong));
      }

      final items = (response as List)
          .map<T>((e) => fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(items);
    } catch (e) {
      return Left(CustomError('Failed to fetch data: $e'));
    }
  }

  @override
  Future<Either<CustomError, T>> getData<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJson,
    required String? filterKey,
    required dynamic value,
  }) async {
    try {
      final response = await supabaseService.getData(
        table: table,
        filterKey: filterKey,
        value: value,
      );

      if (response == null || response.isEmpty) {
        return Left(CustomError(LangKeys.noDataFound));
      }

      final item = fromJson(response.first as Map<String, dynamic>);
      return Right(item);
    } catch (e) {
      return Left(CustomError('Failed to fetch data: $e'));
    }
  }

  @override
  Future<Either<CustomError, T>> addData<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await supabaseService.addData(table: table, data: data);
      final item = fromJson(response as Map<String, dynamic>);
      return Right(item);
    } catch (e) {
      return Left(CustomError('Failed to add data: $e'));
    }
  }

  @override
  Future<bool> checkIfRowExists({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await supabaseService.checkIfRowExists(table: table, data: data);
    } catch (e) {
      throw Exception('Failed to check if row exists: $e');
    }
  }

  @override
  Future<void> update({
    required String table,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await supabaseService.update(
        table: table,
        data: data,
        id: id,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  @override
  Future<void> delete({required String table, required int id}) {
    try {
      var response = supabaseService.delete(table: table, id: id);
      return response;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
