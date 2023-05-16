import 'package:flutter/material.dart';

SnackBar snackBarSos(BuildContext context, Text text, Color? backgroundColor) {
  late Color borderSideColor = Colors.white;
  if (backgroundColor == null) {
    backgroundColor = Colors.red.shade500;
    borderSideColor = Colors.red.shade200;
  }

  return SnackBar(
    content: Container(
      padding: const EdgeInsets.all(3),
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.topCenter,
        child: text,
      ),
    ),
    backgroundColor: backgroundColor,
    // backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(
        color: borderSideColor,
      ),
    ),
    // margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - height, right: 20, left: 20),
  );
}
