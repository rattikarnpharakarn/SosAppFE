import 'package:flutter/material.dart';
import 'package:sos/src/screen/signin.dart';
import 'package:sos/src/screen/signup.dart';

import 'src/screen/signupPhoneNumber.dart';

void main() {
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SosApp',
      theme: ThemeData(primarySwatch: Colors.red),
      // home: const Index(),
      // home: Signup(),
      home: SignupPhoneNumber(),
      // home: Signin(), // หน้าแรกของแอบ
    );
  }
}
