import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/emergency/inform.dart';
import 'package:sos/src/screen/common/LoadingPage.dart';
import '../../component/button_bar_ops.dart';
import 'historyByid.dart';

class HistoryPage extends StatefulWidget {

  const HistoryPage({super.key,});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    callAPIGetInformList();
  }

  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");
  List<GetInform> getInformList = [];

  callAPIGetInformList() async {
    await GetInformListOps().then(
      (value) {
        if (value.code == "0") {
          setState(
            () {
              for (var data in value.list) {
                DateTime dt2 = DateTime.parse(data.date);
                final String date = newFormat.format(dt2);

                DateTime dt = DateTime.parse(data.updateDate);
                final String update = newFormat.format(dt);

                GetInform getInform = GetInform(
                  id: data.id,
                  description: data.description,
                  image: data.image,
                  phoneNumberCallBack: data.phoneNumberCallBack,
                  latitude: data.latitude,
                  longitude: data.longitude,
                  username: data.username,
                  phoneNumber: data.phoneNumber,
                  workplace: data.workplace,
                  subTypeName: data.subTypeName,
                  date: date,
                  updateDate: update,
                  status: data.status,
                );
                getInformList.add(getInform);
              }
            },
          );
        }
      },
    ).onError((error, stackTrace) {
      // todo ต้องเพิ่ม popup
      setState(() {
        isLoading = true;
      });
    });

    setState(() {
      isLoading = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget textRow(String text1, TextStyle textStyle1, String text2,
      TextStyle textStyle2, String text3, TextStyle textStyle3) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          Text(
            text1,
            style: textStyle1,
          ),
          Text(
            text2,
            style: textStyle2,
          ),
          const Spacer(
            flex: 4,
          ),
          Text(
            text3,
            style: textStyle3,
          ),
        ],
      ),
    );
  }

  final int _pageNumber = 2;

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          key: _key,
          bottomNavigationBar: ButtonBarOps(
            pageNumber: _pageNumber,
          ),
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
                          "ประวัติการรับแจ้งเหตุ",
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
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Image_NavBer(height: 40, width: 40),
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
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                for (GetInform m1 in getInformList) ...[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryPageById(getInform: m1),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            textRow(
                              'ประเภท : ',
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              m1.subTypeName,
                              const TextStyle(fontSize: 16, color: Colors.red),
                              m1.date,
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                            ),
                            textRow(
                              'รายละเอียด',
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              '',
                              const TextStyle(fontSize: 16, color: Colors.red),
                              'อัพเดทเมื่อ : ${m1.updateDate}' ,
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                m1.description,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.red),
                              ),
                            ),
                            textRow(
                              'ผู้แจ้งเหตุ : ',
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              m1.username,
                              const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                              '',
                              TextStyle(fontSize: 15.0),
                            ),
                            textRow(
                              'สถานะ : ',
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              m1.status,
                              TextStyle(
                                fontSize: 16,
                                color: m1.status == "รับเรื่องการแจ้งเหตุแล้ว" ? Colors.red :
                                m1.status == "กำลังดำเนินงาน" ? Colors.orange :
                                m1.status == "ดำเนินงานเสร็จสิ้น" ? Colors.green : null,
                              ),
                              '',
                              TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
}
