import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/common/background_service.dart';
import 'package:sos/src/screen/ops/home.dart';
import 'src/provider/common/getCurrentLocation.dart';
import 'src/provider/common/notificationApp.dart';
import 'src/screen/common/LoadingPage.dart';
import 'src/screen/user/home.dart';
import 'src/screen/user/signin.dart';

import 'dart:async';

final FlutterLocalNotificationsPlugin ShowflutterLocalNoificationPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings intiandroidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: intiandroidInitializationSettings,
  );
  await ShowflutterLocalNoificationPlugin.initialize(initializationSettings);


  runApp(const MyApp());
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
    _getUserProfile();
  }

  late UserInfo userInfo;

  _getUserProfile() async {
    UserInfo data = await GetUserProfile();
    setState(() {
      isLoading = true;
      userInfo = data;
    });
  }

  Widget mainSosApp() {
    return MaterialApp(
      title: 'SosApp',
      theme: ThemeData(primarySwatch: Colors.red),
      home: userInfo.id == ''
          ? const Signin()
          : userInfo.roleId == "2"
              ? const Home()
              : const HomeOps(),
      // home: NotiPage(),
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
  Widget build(BuildContext context) =>
      isLoading == false ? mainLoadingPage() : mainSosApp();
}
