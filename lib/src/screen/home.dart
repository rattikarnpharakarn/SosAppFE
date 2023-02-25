import 'dart:ui';

import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sos/src/screen/signin.dart';

import '../component/bottom_bar.dart';
import '../component/form_data.dart';

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

  final int _pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    int a = 10;
    return Scaffold(
      bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: const Text(
                          "Good morning Gig.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          'You need any help?',
                          style: TextStyle(
                            color: Colors.red.shade800,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                      // Image.memory( base64Decode(imageBase64), fit: BoxFit.cover )
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 500,
              height: 250,
              padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage("assets/images/home.jpeg"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    // leading: Icon(Icons.album, size: 60),
                    title: Text('ข่าวสาร',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.white70)),
                    subtitle: Text('เกิดเหตุการณ์ไฟไหม้ที่....',
                        style: TextStyle(fontSize: 27.0, color: Colors.white)),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 230, 0),
                    child: ElevatedButton(
                      child: const Text(
                        'คลิกเพื่ออ่านต่อ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
              child: const Text(
                'แจ้งเหตุ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              height: 400,
              width: 400,
              child: GridView.count(
                primary: true,
                padding: const EdgeInsets.all(5),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  Container(
                    child: Card(
                      color: Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/hospital.png',
                                height: 100,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'โรงพยาบาล',
                                style: TextStyle(
                                  color: Color.fromRGBO(12, 75, 142, 1),
                                  fontSize: 25,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      color: Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/emg.png',
                                height: 100,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'ปอเต็กตึ๊ง',
                                style: TextStyle(
                                  color: Color.fromRGBO(12, 75, 142, 1),
                                  fontSize: 25,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      color: Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/fire.png',
                                height: 100,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'สถานีดับเพลิง',
                                style: TextStyle(
                                  color: Color.fromRGBO(12, 75, 142, 1),
                                  fontSize: 25,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      color: Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/other.png',
                                height: 100,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'สถานีตำรวจ',
                                style: TextStyle(
                                  color: Color.fromRGBO(12, 75, 142, 1),
                                  fontSize: 25,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
