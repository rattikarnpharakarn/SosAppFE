import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/screen/ops/home.dart';
import 'package:sos/src/screen/user/sos.dart';
import 'package:sos/src/sharedInfo/user.dart';
import 'src/screen/common/LoadingPage.dart';
import 'src/screen/chats/screens/chat.dart';
import 'src/screen/user/home.dart';
import 'src/screen/user/signin.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final FlutterLocalNotificationsPlugin ShowflutterLocalNoificationPlugin =
    FlutterLocalNotificationsPlugin();

late IO.Socket _socket;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings intiandroidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // ignore: prefer_const_constructors
  final InitializationSettings initializationSettings = InitializationSettings(
    android: intiandroidInitializationSettings,
  );

  await ShowflutterLocalNoificationPlugin.initialize(initializationSettings);

  UserInfo data = await GetUserProfile();
  if (data.roleId != "2") {
    _socket = IO.io(
      urlWsMessenger,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({
        'username': data.firstName + " " + data.lastName,
      }).build(),
    );

    _socket.connect();
    _socket.on('emergency', (data) {
      print(jsonEncode(data));
      //todo FlutterLocalNotificationsPlugin
    });
  }

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
    _getUserProfile();
  }

  late UserInfo userInfo;

  _getUserProfile() async {
    UserInfo data = await GetUserProfile();
    // print(userInfo.roleId);
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
              ? Home()
              : HomeOps(socket: _socket),
      // home: SosPage(),
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
