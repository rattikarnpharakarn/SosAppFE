import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import '../sharedInfo/user.dart';
import 'dart:typed_data';

class Image_Profile extends StatefulWidget {
  final double width ;
  final double height ;
  final String userId;

  Image_Profile({super.key, required this.width, required this.height, required this.userId});

  @override
  State<Image_Profile> createState() => _Image_Profile();
}

class _Image_Profile extends State<Image_Profile> {

  @override
  void initState() {
    super.initState();
    _getImageProfile();
  }

  String _imageProfile = '';
  _getImageProfile() async {
    UserImage image = await GetUserImageById(widget.userId);
    setState(() {
      _imageProfile = image.imageProfile;
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
