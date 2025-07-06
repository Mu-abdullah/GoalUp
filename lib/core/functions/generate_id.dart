import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenerateId {
  static String generateDocumentId({
    required BuildContext context,
    String? academy,
    String? userId,
    String? table,
    String format = 'yyMMddHHmmss',
    int? count,
  }) {
    try {
      final DateTime now = DateTime.now();
      final String date = DateFormat(format, 'en').format(now);
      final String? tab = table?.substring(0, 3).toUpperCase();
      final String? acad = academy?.substring(0, 3).toUpperCase();
      final String? user = userId?.substring(0, 3).toUpperCase();

      return 'GU-EG-${tab ?? "-"}${acad ?? ""}${user ?? ""}$date${count ?? ''}';
    } catch (e) {
      throw Exception('Failed to generate document ID: $e');
    }
  }
}
