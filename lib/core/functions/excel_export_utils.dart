import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;

class ExcelExportUtils {
  /// Generic function to export data to an Excel file.
  /// - [data]: List of data objects to export.
  /// - [columns]: List of column definitions (header and data getter).
  /// - [excelName]: Name of the output file (without extension).
  /// - [sheetName]: Name of the Excel sheet (optional, defaults to 'Sheet1').
  ///
  static Future<void> exportToExcel<T>({
    required List<T> data,
    required List<ExcelColumn<T>> columns,
    required String excelName,
    String sheetName = 'Sheet1',
  }) async {
    // Create a new workbook and sheet
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = sheetName;

    // Set column headers
    for (int colIndex = 0; colIndex < columns.length; colIndex++) {
      sheet
          .getRangeByName('${String.fromCharCode(65 + colIndex)}1')
          .setText(columns[colIndex].header);
    }

    // Populate data
    for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
      final T item = data[rowIndex];
      for (int colIndex = 0; colIndex < columns.length; colIndex++) {
        final value = columns[colIndex].dataGetter(item);
        sheet
            .getRangeByName(
              '${String.fromCharCode(65 + colIndex)}${rowIndex + 2}',
            )
            .setText(value?.toString() ?? '');
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      final String base64String = base64.encode(bytes);
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,$base64String',
        )
        ..setAttribute('download', '$excelName.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
          Platform.isWindows
              ? "$path\\$excelName.xlsx"
              : "$path/$excelName.xlsx";
      final File file = File(fileName);

      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
}

class ExcelColumn<T> {
  final String header;
  final dynamic Function(T) dataGetter;

  ExcelColumn({required this.header, required this.dataGetter});
}
