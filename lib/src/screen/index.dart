import 'package:flutter/material.dart';
import 'package:sos/src/screen/signin.dart';


class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Signin());
  }
}
