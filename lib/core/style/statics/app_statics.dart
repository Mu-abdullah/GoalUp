import 'package:flutter/material.dart';

class AppBorderRadius {
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mediumRadius = BorderRadius.all(
    Radius.circular(12),
  );
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(16));
}

class AppPadding {
  static EdgeInsets smallPadding = const EdgeInsets.all(8);
  static EdgeInsets mediumPadding = const EdgeInsets.all(16);
  static EdgeInsets largePadding = const EdgeInsets.all(24);

  static EdgeInsets symmetricPadding({
    double horizontal = 16,
    double vertical = 8,
  }) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets only({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) {
    return EdgeInsets.only(top: top, right: right, bottom: bottom, left: left);
  }
}

class Statics {
  static const double buttonsHeight = 70;
  static const double appBarHeight = 56;

  static const double defaultSize = 100;
}

class Validation {
  static var regExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
}
