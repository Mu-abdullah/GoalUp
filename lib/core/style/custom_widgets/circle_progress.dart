import 'package:flutter/material.dart';

void showProgressIndicator(context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.black.withValues(alpha: 0.5),
    elevation: 0,
    content: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.black.withValues(alpha: 0.5),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}
