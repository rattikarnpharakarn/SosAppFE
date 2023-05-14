import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/main.dart';
import 'package:sos/src/provider/config.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sos/src/screen/common/snack_bar_sos.dart';
import 'package:sos/src/screen/user/signupPhoneNumber.dart';
import 'dart:developer' as developer;

import '../../model/accounts/signup.dart';
import 'signup.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key, required this.data}) : super(key: key);

  final Param data;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final TextEditingController _controllerBox1 = TextEditingController();
  final TextEditingController _controllerBox2 = TextEditingController();
  final TextEditingController _controllerBox3 = TextEditingController();
  final TextEditingController _controllerBox4 = TextEditingController();
  late String otpValue = '';
  late String verifyCode = '';
  late String phone = widget.data.phone;

  @override
  void initState() {
    super.initState();
    _controllerBox1.addListener(() {
    });
    _controllerBox2.addListener(() {
    });
    _controllerBox3.addListener(() {
    });
    _controllerBox4.addListener(() {
    });

    setState(() {
      verifyCode = widget.data.verifyCode['verifyCode'].toString();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerBox1.dispose();
    _controllerBox2.dispose();
    _controllerBox3.dispose();
    _controllerBox4.dispose();

    super.dispose();
  }



  Future<Data> verifyOTP(
      String box1, String box2, String box3, String box4) async {
     otpValue =
        box1.toString() + box2.toString() + box3.toString() + box4.toString();
    final response = await http.post(
      Uri.parse('${urlAccount}verifyOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'otp': otpValue,
        'phoneNumber': phone,
        'verifyCode': verifyCode,
      }),
    );

    final UserInfo userinfo = UserInfo(
      phoneNumber: widget.data.phone,
      birthday: '',
      confirmPassword: '',
      email: '',
      firstName: '',
      gender: '',
      imageProfile: '',
      role: 2,
      lastName: '',
      password: '',
      pathImage: '',
      textIDCard: '',
      address: '',
      country: '',
      district: '',
      postalCode: '',
      province: '',
      subDistrict: '',
      otp: otpValue,
      verifyCode: verifyCode,
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Signup(
            userInfo: userinfo,
          );
        }),
      );
      return Data.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Send APIName : verifyOTP || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
    }
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

  _sendOTP() async {
    final response = await http.post(
      Uri.parse('${urlAccount}sendOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': phone,
      }),
    );

    if (response.statusCode == 200) {
      final vf = json.decode(response.body);

      String otp = vf["data"]['otp'];
      setState(() {
        verifyCode = vf["data"]['verifyCode'];
      });
      // ignore: use_build_context_synchronously
      _showNotification(otp, verifyCode);
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
                      // widget.data.verifyCode['verifyCode'].toString(),
                      "OTP",
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
                      "Please enter your number to request OTP",
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox1,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headlineLarge,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox2,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headlineLarge,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox3,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headlineLarge,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox4,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              style: Theme.of(context).textTheme.headlineLarge,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          )
                        ]),
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

                          if (_controllerBox1.text.length == 1 &&
                              _controllerBox2.text.length == 1 &&
                              _controllerBox3.text.length == 1 &&
                              _controllerBox4.text.length == 1
                          ){
                            verifyOTP(
                                _controllerBox1.text,
                                _controllerBox2.text,
                                _controllerBox3.text,
                                _controllerBox4.text);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarSos(
                                context,
                                const Text(
                                  'กรุณากรอก OTP ให้ครบ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Colors.white,
                                115
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              _sendOTP();
                            },
                          ),
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}


class Data {
  final String data;

  const Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
    );
  }
}
