import 'package:flutter/material.dart';
import 'package:sos/src/component/bottom_bar.dart';

class HotlinePage extends StatefulWidget {
  const HotlinePage({super.key});

  @override
  State<HotlinePage> createState() => HhotlinePageState();
}

class HhotlinePageState extends State<HotlinePage> {
  @override
  Widget build(BuildContext context) {
    int a = 10;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: const Text(
            'Hotline',
            style: TextStyle(fontSize: 24),
          ),
        ),
        // toolbarHeight: 50,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        titleSpacing: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
      ),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
                                          style: TextStyle(fontSize: 23.0,color: Colors.red)),
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
      bottomNavigationBar: Bottombar(
        pageNumber: 1,
      ),
    );
  }
}
