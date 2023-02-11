import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sos/src/screen/signup.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
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
                      "Please enter your number to OTP",
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
                              style: Theme.of(context).textTheme.headline5,
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
                              style: Theme.of(context).textTheme.headline5,
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
                              style: Theme.of(context).textTheme.headline5,
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
                              style: Theme.of(context).textTheme.headline5,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Signup();
                          }));
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
                            onPressed: () {},
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
