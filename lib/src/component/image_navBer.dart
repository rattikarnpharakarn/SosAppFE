import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class Image_NavBer extends StatefulWidget {
  Image_NavBer({
    super.key,
    required this.imagebase64string,
  });

  String imagebase64string;

  @override
  // ignore: no_logic_in_create_state
  State<Image_NavBer> createState() =>
      _Image_NavBerState(imagebase64: imagebase64string);
}

class _Image_NavBerState extends State<Image_NavBer> {
  _Image_NavBerState({
    required this.imagebase64,
  });

  String imagebase64 = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: Container(
          padding: EdgeInsets.zero,
          child: imagebase64 != ''
              ? Image.memory(
                  base64Decode(imagebase64),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/profile.webp',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
