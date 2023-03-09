import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/src/testPage/test.dart';
import 'package:sos/src/sharedInfo/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/src/screen/chat.dart';
import 'package:sos/src/screen/home.dart';
import 'package:sos/src/screen/hotline.dart';
import 'package:sos/src/screen/signin.dart';
import 'package:sos/src/screen/signup.dart';
import 'package:sos/src/screen/sos.dart';
import 'package:sos/src/screen/updateProfile.dart';

import 'src/screen/LoadingPage.dart';
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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = false;

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      await _getImageProfile();
    });
  }

  String _token = '';

  _getImageProfile() async {
    var token = await getUserTokenSf();
    setState(() {
      _token = token;
      isLoading = true;
    });
  }

  Widget mainSosApp() {
    return MaterialApp(
      title: 'SosApp',
      theme: ThemeData(primarySwatch: Colors.red),
      // home: Home(),
      // home: const SosPage(),
      // home: HotlinePage(),
      // home: Signup(),
      // home: SignupPhoneNumber(),
      // home: SosPage1(),
      // home: UpDataProfilePage(),
      // home: ChatPage(),
      // home: TestPage(),
      home: _token == '' ? Signin() : Home(), // หน้าแรกของแอบ
    );
  }

  Widget mainLoadingPage() {
    return MaterialApp(
      title: 'SosApp',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const LoadingPage(),
    );
  }

  @override
  Widget build(BuildContext context) => isLoading == false
      ? mainLoadingPage()
      : mainSosApp();
}


