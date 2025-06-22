import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../language/lang_keys.dart';
import '../style/widgets/app_text.dart';

void selectData({
  required BuildContext context,
  required TextEditingController controller,
  required String content,
  String format = 'yyyy-MM-dd',
}) {
  var date = BottomPicker.date(
    pickerTitle: AppText(content),
    layoutOrientation: TextDirection.rtl,
    dateOrder: DatePickerDateOrder.dmy,
    initialDateTime: DateTime.now(),
    maxDateTime: DateTime(2050),
    minDateTime: DateTime(1950),
    pickerTextStyle: customTextStyle(context),
    buttonContent: const AppText(
      LangKeys.chooseDate,
      color: Colors.white,
      textAlign: TextAlign.center,
    ),
    buttonStyle: const BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    onChange: (index) {},
    onSubmit: (index) async {
      var date = convertDateToArabic(index.toString(), format: format);
      controller.text = date;
    },
    bottomPickerTheme: BottomPickerTheme.blue,
  );

  date.show(context);
}

String convertDateToArabic(String dateString, {required String format}) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = intl.DateFormat(format).format(dateTime);
  return formattedDate;
}
