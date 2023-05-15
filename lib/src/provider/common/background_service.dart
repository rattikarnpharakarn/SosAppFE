import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/common/getCurrentLocation.dart';
import 'package:sos/src/provider/common/model.dart';
import 'package:sos/src/provider/common/notificationApp.dart';

import 'package:sos/src/provider/common/socketConnectNotification.dart';
import 'package:sos/src/provider/config.dart';

late double latitude;
late double longitude;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  // if (Platform.isIOS) {
  //   await flutterLocalNotificationsPlugin.initialize(
  //     const InitializationSettings(
  //       iOS: IOSInitializationSettings(),
  //     ),
  //   );
  // }
  // UserInfo data = await GetUserProfile();
  //
  // if (data.roleId == "3")  {
  //   await getCurrentLocation().then((value) async {
  //     latitude = value.latitude;
  //     longitude = value.longitude;
  //     liveLocation();
  //   });
  // }

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  UserInfo data = await GetUserProfile();
  late IO.Socket _socket;
  if (data.roleId == "3") {
    _socket = await connectSocket(data);
    // todo Check location
    _socket.on('0', (data) {
      notificationEmergency(data);
    });
  }

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

  // bring to foreground
  // Timer.periodic(const Duration(seconds: 5), (timer) async {
  //   if (service is AndroidServiceInstance) {
  //     if (await service.isForegroundService()) {
  //       if (data.roleId == "3") {
  //         // socket.on('emergency', (data) async {
  //         //   await notificationEmergency(data.toString());
  //         //   print(" +++++++++++++ data : " + data.toString());
  //         // });
  //       }
  //     }
  //   }
  //
  //   // await notificationEmergency(data.toString());
  //
  //   // test using external plugin
  //   final deviceInfo = DeviceInfoPlugin();
  //   String? device;
  //   if (Platform.isAndroid) {
  //     final androidInfo = await deviceInfo.androidInfo;
  //     device = androidInfo.model;
  //   }
  //
  //   if (Platform.isIOS) {
  //     final iosInfo = await deviceInfo.iosInfo;
  //     device = iosInfo.model;
  //   }
  //
  //   service.invoke(
  //     'update',
  //     {
  //       "current_date": DateTime.now().toIso8601String(),
  //       "device": device,
  //     },
  //   );
  // });
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
