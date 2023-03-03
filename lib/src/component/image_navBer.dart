import 'dart:convert';
import 'package:flutter/material.dart';
import '../sharedInfo/user.dart';
import 'dart:typed_data';

class Image_NavBer extends StatefulWidget {
  const Image_NavBer({
    super.key,
  });

  @override
  // ignore: no_logic_in_create_state
  State<Image_NavBer> createState() => _Image_NavBerState();
}

class _Image_NavBerState extends State<Image_NavBer> {
  @override
  void initState() {
    super.initState();
  }

  final imagebase64 = getUserTokenSf();

  // String imagebase64 = getUserImageProfileSF().toString();

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
                  width: 30,
                  height: 30,
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
