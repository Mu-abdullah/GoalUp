import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_services.dart';

class SupabaseServicesRepo implements SupabaseServices {
  final supabase = Supabase.instance.client;

  @override
  Future<dynamic> getData({
    required String table,
    int? limit,
    String? searchKey,
    String? filterKey,
    dynamic value,
    String? orderBy,
    bool? ascending,
  }) async {
    final response = supabase.from(table);

    // set limit if limit is not null
    if (limit != null) {
      return await response
          .select()
          .limit(limit)
          .order(
            orderBy ?? 'created_at',
            ascending: ascending ?? orderBy != null,
          );
    }
    // set search if searchKey and value is not null
    else if (searchKey != null && value != null) {
      return await response.select().ilike(searchKey, '%$value%');
    }
    // set filter if filterKey and value is not null
    else if (filterKey != null && value != null) {
      return await response.select().eq(filterKey, value);
    }

    // return all data if no parameters are provided
    return await response.select();
  }

  @override
  Future<dynamic> addData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response =
          await supabase.from(table).insert(data).select().single();
      return response;
    } catch (e) {
      throw Exception('Failed to add data: $e');
    }
  }

  @override
  Future<bool> checkIfRowExists({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      var query = supabase.from(table).select();

      data.forEach((key, value) {
        if (value != null) {
          query = query.eq(key, value);
        }
      });

      final response = await query.limit(1);
      return response.isNotEmpty;
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
      var response = await supabase.from(table).update(data).eq('id', id);
      return response;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  @override
  Future<void> delete({required String table, required int id}) async {
    try {
      var response = await supabase.from(table).delete().eq('id', id);
      return response;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
