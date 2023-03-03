import 'dart:ui';

import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/component/navBar.dart';
import 'package:sos/src/screen/signin.dart';

import '../component/bottom_bar.dart';
import '../component/form_data.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final PageController controller = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  final int _pageNumber = 3;

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
                      "ประวัติการแจ้งเหตุ",
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
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Image_NavBer(),
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
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ประเภท:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('อาคาร/สถานที่',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('03/12/2022',
                                          style: TextStyle(fontSize: 15.0)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('รายละเอียด:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child:
                                          const Text('มีไฟไหม้ที่Central World',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ผู้รับแจ้ง:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('ดาบตำรวจ xxx',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('สน.ที่รับแจ้ง:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('ราชดำริ',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('สถานะ:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('ดำเนินการเรียบร้อย',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(
                                      flex: 4,
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ประเภท:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('อื่นๆ',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('10/11/2022',
                                          style: TextStyle(fontSize: 15.0)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('รายละเอียด:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('มีรถชนกันหน้าctw',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('ผู้รับแจ้ง:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('ดาบตำรวจ xxx',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('สน.ที่รับแจ้ง:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('ราชดำริ',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text('สถานะ:',
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                    Container(
                                      child: const Text('ดำเนินการเรียบร้อย',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const Spacer(
                                      flex: 4,
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
