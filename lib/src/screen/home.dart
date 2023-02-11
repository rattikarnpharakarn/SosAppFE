import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sos/src/screen/signin.dart';

import '../component/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottombar(),
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
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 63.4,
                      // child: ElevatedButton(
                      //   style: ButtonStyle(
                      //       backgroundColor:
                      //           MaterialStateProperty.all(Colors.black),
                      //       shape: MaterialStateProperty.all(
                      //           RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(15.29),
                      //               side: const BorderSide(
                      //                   width: 3, color: Colors.black)))),
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return const Signin();
                      //     }));
                      //   },
                      //   child: const Text(
                      //     "Continue",
                      //     style: TextStyle(fontSize: 24),
                      //   ),
                      // ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
