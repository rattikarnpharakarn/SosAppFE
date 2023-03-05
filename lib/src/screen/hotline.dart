import 'package:flutter/material.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';

class HotlinePage extends StatefulWidget {
  const HotlinePage({super.key});

  @override
  State<HotlinePage> createState() => HhotlinePageState();
}

class HhotlinePageState extends State<HotlinePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int _pageNumber = 1;

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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      "Hotline",
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
                 child: Image_NavBer(height: 40,width: 40),
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
      endDrawer: EndDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: const Text(
                  'เบอร์โทรสายด่วน',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('เหตุด่วนเหตุร้าย',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('191',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ตำรวจทางหลวง',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('1193',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ศูนย์รับแจ้งรถหาย',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('1192',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('โรงพยาบาลตำรวจ',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('1691',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ตำรวจท่องเที่ยว',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('1155',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ตำรวจจราจร',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('1197',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('เหตุฉุกเฉิน',
                                          style: TextStyle(fontSize: 22.0)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('1669',
                                          style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.red)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
