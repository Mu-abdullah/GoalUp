import 'package:sport/core/extextions/extentions.dart';
import 'package:flutter/material.dart';

class FontsHelper {
  static const String monsterrat = 'monsterrat';
  static const String almarai = 'almarai';
  static const String pop = 'popp';
  static const String inter = 'inter';

  static String fontLangFamily(BuildContext context) {
    if (context.langCode == 'ar') {
      return almarai;
    } else {
      return monsterrat;
    }
  }
}
