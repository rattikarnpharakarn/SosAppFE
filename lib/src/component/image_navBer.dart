import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sharedInfo/user.dart';
import 'dart:typed_data';

class Image_NavBer extends StatefulWidget {
  final double width ;
  final double height ;

  Image_NavBer({super.key, required this.width, required this.height});

  @override
  State<Image_NavBer> createState() => _Image_NavBerState();
}

class _Image_NavBerState extends State<Image_NavBer> {

  @override
  void initState() {
    super.initState();
    _getImageProfile();

  }




  String _imageProfile = '';
  _getImageProfile() async {
    var imageProfile = await getUserImageProfileSF();
    setState(() {
      _imageProfile = imageProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: Container(
          padding: EdgeInsets.zero,
          child: _imageProfile != ''
              ? Image.memory(
                  base64Decode(_imageProfile),
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
