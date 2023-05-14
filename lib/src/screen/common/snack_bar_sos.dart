import 'package:flutter/material.dart';

SnackBar snackBarSos(BuildContext context, Text text, Color backgroundColor) {
  return SnackBar(
    content: Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: double.maxFinite,
        child: text,
      ),
    ),
    backgroundColor: Colors.red.shade500,
    // backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(
        color: Colors.red.shade200,
      ),
    ),
    // margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - height, right: 20, left: 20),
  );
}
