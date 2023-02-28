import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/src/screen/chat.dart';
import 'package:sos/src/screen/hotline.dart';
import 'package:sos/src/screen/signin.dart';
import 'package:sos/src/screen/signup.dart';
import 'package:sos/src/screen/sos.dart';

import 'src/screen/index.dart';
import 'src/screen/signupPhoneNumber.dart';

final FlutterLocalNotificationsPlugin ShowflutterLocalNoificationPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings intiandroidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // ignore: prefer_const_constructors
  final InitializationSettings initializationSettings = InitializationSettings(
    android: intiandroidInitializationSettings,
  );

  await ShowflutterLocalNoificationPlugin.initialize(initializationSettings);

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
      // home: MyhomePage(),
      // home: const SosPage(),
      // home: HotlinePage(),
      // home: Signup(),
      // home: SignupPhoneNumber(),
      // home: SosPage1(),
      home: ChatPage(),
      // home: Signin(), // หน้าแรกของแอบ
    );
  }
}
