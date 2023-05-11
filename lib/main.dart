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

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  await initializeService();

  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   'my_foreground', // id
  //   'MY FOREGROUND SERVICE', // title
  //   description:
  //       'This channel is used for important notifications.', // description
  //   importance: Importance.high, // importance must be at low or higher level
  // );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // if (Platform.isIOS) {
  //   await flutterLocalNotificationsPlugin.initialize(
  //     const InitializationSettings(
  //       iOS: IOSInitializationSettings(),
  //     ),
  //   );
  // }

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      // notificationChannelId: 'my_foreground',
      // initialNotificationTitle: 'AWESOME SERVICE',
      // initialNotificationContent: 'Initializing',
      // foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  UserInfo data = await GetUserProfile();
  if (data.roleId != "2") {
    _socket = IO.io(
      urlWsMessenger,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({
        'username': data.firstName + " " + data.lastName,
      }).build(),
    );
    _socket.connect();


    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'nextflow_noti_SOS',
      'SOS',
      channelDescription: 'SOS',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    _socket.on('emergency', (m1) async {
      await ShowflutterLocalNoificationPlugin.show(
        2,
        'SOS',
        m1.toString(),
        platformChannelDetails,
      );
      print(" +++++++++++++ data : " + m1.toString());
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {}
      }

      // await ShowflutterLocalNoificationPlugin.show(
      //     2,
      //     'SOS',
      //     'Data ${data.id}',
      //     platformChannelDetails);

      // _socket.emit("emergency", {
      //   'message': "1",
      //   'sender': data.firstName + " " + data.lastName,
      // });



      // await ShowflutterLocalNoificationPlugin.show(
      //   222,
      //   'TEST',
      //   "TEST",
      //   platformChannelDetails,
      // );

      /// you can see this log in logcat
      // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

      // test using external plugin
      final deviceInfo = DeviceInfoPlugin();
      String? device;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        device = androidInfo.model;
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        device = iosInfo.model;
      }

      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "device": device,
        },
      );
    });
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
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
              ? Home()
              : HomeOps(),
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
