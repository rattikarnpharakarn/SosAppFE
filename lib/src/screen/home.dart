import 'dart:ui';

import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/navBar.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  final int _pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
      // appBar: NavbarPages(),
      appBar: AppBar(
        // toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
        // centerTitle: false,
        title: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    child: const Text(
                      "Hi Gig.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: Container(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          'assets/images/profile.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _key.currentState!.openEndDrawer();
                  },
                ),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        actions: [
          Container(),
        ],
      ),
      endDrawer: const EndDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              width: 500,
              height: 250,
              padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
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
              padding: EdgeInsets.zero,
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
                    padding: EdgeInsets.zero,
                    child: Card(
                      color: Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/hospital.png',
                                height: 100,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: const Text(
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
                    padding: EdgeInsets.zero,
                    child: Card(
                      color: const Color.fromRGBO(210, 250, 251, 1),
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
                              child: const Text(
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
                    padding: EdgeInsets.zero,
                    child: Card(
                      color: const Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/fire.png',
                                height: 100,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: const Text(
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
                    padding: EdgeInsets.zero,
                    child: Card(
                      color: const Color.fromRGBO(210, 250, 251, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Image.asset(
                                'assets/images/other.png',
                                height: 100,
                              )),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: const Text(
                              'สถานีตำรวจ',
                              style: TextStyle(
                                color: Color.fromRGBO(12, 75, 142, 1),
                                fontSize: 25,
                              ),
                            ),
                          ),
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
