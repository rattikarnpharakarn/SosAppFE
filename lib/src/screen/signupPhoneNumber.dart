import 'package:flutter/material.dart';

import '../../main.dart';
import 'otp.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class SignupPhoneNumber extends StatefulWidget {
  SignupPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SignupPhoneNumber> createState() => _SignupPhoneNumberState();
}

class _SignupPhoneNumberState extends State<SignupPhoneNumber> {
  final TextEditingController _controllerPhone = TextEditingController();

  Future<Data>? _futureOTP;

  String _phone = '';

  @override
  void initState() {
    super.initState();
    _controllerPhone.addListener(() {
      setState(() {
        _phone = _controllerPhone.text;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerPhone.dispose();

    super.dispose();
  }

  Future<void> _showNotification(String otp, verifyCode) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'nextflow_noti_001',
      'แจ้งเตือน',
      channelDescription: 'OTP',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await ShowflutterLocalNoificationPlugin.show(
        1,
        'OTP',
        'OTP=${otp} [รหัสอ้างอิง:${verifyCode}] เพื่อใช้งานระบบ SOS',
        platformChannelDetails);
  }

  Future<Data> Singupwithphone(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:80/SosApp/accounts/sendOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      final vf = json.decode(response.body);
      final item = Param(
        phone: phoneNumber,
        verifyCode: vf["data"],
      );

      String otp = vf["data"]['otp'];
      String verifyCode = vf["data"]['verifyCode'];
      // ignore: use_build_context_synchronously
      _showNotification(otp, verifyCode);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTP(data: item),
        ),
      );

      return Data.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 0, 0),
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: const Text(
                      "Please enter your number to phone nubmer",
                      style: TextStyle(
                        color: Color.fromARGB(156, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    margin: const EdgeInsets.all(15),
                    child: TextField(
                      controller: _controllerPhone,
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: TextStyle(color: Colors.white),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 63.4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.29),
                                    side: const BorderSide(
                                        width: 3, color: Colors.black)))),
                        onPressed: () {
                          setState(() {
                            _futureOTP = Singupwithphone(_controllerPhone.text);
                          });
                        },
                        child: const Text(
                          "Request OTP",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class Data {
  Data(this.otp, this.verifyCode);
  final Null otp;
  final Null verifyCode;
  // named constructor
  Data.fromJson(Map<String, dynamic> json)
      : otp = json['otp'],
        verifyCode = json['verifyCode'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'verifyCode': verifyCode,
    };
  }
}

class Param {
  String phone;
  dynamic verifyCode;

  Param({required this.phone, required this.verifyCode});
}
