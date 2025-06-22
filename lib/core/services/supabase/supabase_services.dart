abstract class SupabaseServices {
  Future<dynamic> getData({
    required String table,
    int? limit,
    String? searchKey,
    String? filterKey,
    dynamic value,
  });
  Future<dynamic> addData({
    required String table,
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

  Future<void> delete({
    required String table,
    required int id,
  });
}
