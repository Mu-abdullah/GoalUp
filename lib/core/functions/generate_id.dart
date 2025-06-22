import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenerateId {
  static String generateDocumentId({
    required BuildContext context,
    required String tableName,
    String? userId,
    required String companyName,
  }) {
    try {
      final DateTime now = DateTime.now();
      final String date = DateFormat('yyMMddHHmmss', 'en').format(now);
      final String table = tableName.substring(0, 3).toUpperCase();
      final String? user = userId?.substring(0, 3).toUpperCase();
      final String comp = companyName.substring(0, 3).toUpperCase();

      return 'TE-$table-$comp-${user ?? ""}$date';
    } catch (e) {
      throw Exception('Failed to generate document ID: $e');
    }
  }
}
