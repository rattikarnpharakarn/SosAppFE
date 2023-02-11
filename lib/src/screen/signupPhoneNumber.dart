import 'package:flutter/material.dart';

import 'otp.dart';


class SignupPhoneNumber extends StatefulWidget {
  const SignupPhoneNumber({super.key});

  @override
  State<SignupPhoneNumber> createState() => _SignupPhoneNumberState();
}

class _SignupPhoneNumberState extends State<SignupPhoneNumber> {
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
                    child: const TextField(
                      decoration: InputDecoration(
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
                      style: TextStyle(color: Colors.white),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OTP();
                          }));
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
