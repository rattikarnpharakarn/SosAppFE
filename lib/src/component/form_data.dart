import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';

class Form_Data extends StatelessWidget {
  late String title;
  double left = 0.0;
  double top = 0.0;
  double right = 0.0;
  double bottom = 0.0;
  TextInputType type;

  Form_Data(
      this.title, this.left, this.top, this.right, this.bottom, this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      margin: const EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          labelText: title,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
          enabledBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(255, 182, 182, 182)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Color.fromARGB(255, 182, 182, 182)),
          ),
        ),
        keyboardType: type,
        obscureText: false,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
