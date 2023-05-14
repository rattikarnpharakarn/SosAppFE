
import 'dart:convert';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String images;

  DetailScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.memory(
              base64Decode(widget.images),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
