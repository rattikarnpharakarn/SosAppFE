import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/main.dart';
import 'package:sos/src/provider/common/getCurrentLocation.dart';
import 'package:sos/src/provider/common/getDistanceBetweenPoints.dart';
import 'package:sos/src/provider/common/model.dart';

Future<void> showNotificationOTP(String otp, verifyCode) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'nextflow_noti_001',
    'OTP',
    channelDescription: 'OTP',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await ShowflutterLocalNoificationPlugin.show(
      001,
      'OTP',
      'OTP=${otp} [รหัสอ้างอิง:${verifyCode}] เพื่อใช้งานระบบ SOS',
      platformChannelDetails);
}

Future<void> notificationEmergency(res) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'nextflow_noti_002',
    'SOS emergency',
    channelDescription: 'emergency',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelDetails = NotificationDetails(
    android: androidNotificationDetails,
  );


  var resp = NotificationModel.fromJson(res);

  // todo CurrentLocation
  late double currentLatitude =0.0;
  late double currentLongitude =0.0;


  // todo Destination Location
  final double latitude =double.parse(resp.latitude);
  final double longitude = double.parse(resp.longitude);

  await getCurrentLocation().then((value) async {
    currentLatitude = value.latitude;
    currentLongitude = value.longitude;
    liveLocation();
  });

  double unit = await getDistanceBetweenPoints(
      latitude, longitude, currentLatitude, currentLongitude, "kilometers");
  unit += 2;
  final String kilometer  = unit.toStringAsFixed(2);

  String msg = 'คำอธิบาย : ${resp.description} \n'
      "ระยะห่างจากคุณ โดยประมาณ : $kilometer กิโลเมตร";
  await ShowflutterLocalNoificationPlugin.show(
      002, 'การแจ้งเหตุ : ${resp.type}', msg, platformChannelDetails,
      payload: "Description");
}
