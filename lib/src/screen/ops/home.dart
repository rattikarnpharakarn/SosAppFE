// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos/src/component/button_bar_ops.dart';
import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/common/background_service.dart';
import 'package:sos/src/provider/common/getCurrentLocation.dart';
import 'package:sos/src/provider/common/getDistanceBetweenPoints.dart';
import 'package:sos/src/provider/emergency/inform.dart';
import 'package:sos/src/screen/common/detailImage.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';
import 'package:sos/src/screen/ops/history.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../component/endDrawer.dart';
import '../../component/image_navBer.dart';
import '../../sharedInfo/user.dart';
import '../common/LoadingPage.dart';

class HomeOps extends StatefulWidget {
  const HomeOps({super.key});

  @override
  State<HomeOps> createState() => _HomeOpsState();
}

class _HomeOpsState extends State<HomeOps> {
  final PageController controller = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late double currentLatitude = 0.0;
  late double currentLongitude = 0.0;

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  final int _pageNumber = 0;

  String _name = '';

  _getNameProfile() async {
    var name = await getUserFirstNameSF();
    setState(() {
      _name = name;
    });
  }

  _getCurrentLocation() async {
    await getCurrentLocation().then((value) async {
      setState(() {
        currentLatitude = value.latitude;
        currentLongitude = value.longitude;
      });
      liveLocation();
    });

    await initializeService();
    await _getNameProfile();
    await callAPIGetInformList();
  }

  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");
  List<GetInform> getInformList = [];

  callAPIGetInformList() async {
    await GetInformListAll().then(
      (value) {
        if (value.code == "0") {
          setState(
            () {
              Future.forEach(value.list, (data) async {
                DateTime dt2 = DateTime.parse(data.date);
                final String date = newFormat.format(dt2);

                DateTime dt = DateTime.parse(data.updateDate);
                final String update = newFormat.format(dt);

                bool check = await checkDistanceBetweenPoints(
                  currentLatitude,
                  currentLongitude,
                  data.latitude,
                  data.longitude,
                );
                if (check) {
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
                    statusChat: data.statusChat,
                  );
                  getInformList.add(getInform);
                }
              });
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
                        child: Text(
                          "Hi $_name",
                          style: const TextStyle(
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
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    "การรับแจ้งเหตุ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
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
                              const TextStyle(
                                  fontSize: 15.0, color: Colors.black54),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(2),
                              child: const Text(
                                'รายละเอียด',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                              const TextStyle(fontSize: 15.0),
                            ),
                            textRow(
                              'สถานะ : ',
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              m1.status,
                              const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                              '',
                              const TextStyle(fontSize: 15.0),
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

class HistoryPageById extends StatefulWidget {
  GetInform getInform;

  HistoryPageById({Key? key, required this.getInform}) : super(key: key);

  @override
  State<HistoryPageById> createState() => _HistoryPageByIdState();
}

class _HistoryPageByIdState extends State<HistoryPageById> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getInformById();
  }

  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");
  late GetInformByIdModel getInformById;
  List<String> imagepages = [];

  _getInformById() async {
    GetInformByIdModel data = await GetInformByIdOps(widget.getInform.id);

    setState(() {
      for (var data in data.images!) {
        imagepages.add(data.image);
      }
      getInformById = data;
      isLoading = true;
    });
  }

  final int _pageNumber = 0;

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

  Future<void> _openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';

    await launchUrlString(googleURL);
  }

  Future<ReturnResponse> _updateInform() async {
    String opsIdStr = await getUserIDSF();
    var infomrId = widget.getInform.id;
    var opsId = int.parse(opsIdStr);
    var status = 2;
    UpdateInform req = UpdateInform(
      opsID: opsId,
      status: status,
      statusChat: false,
    );

    Future<ReturnResponse> res = UpdateInformOps(req, infomrId);

    return res;
  }

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          key: _key,
          bottomNavigationBar: ButtonBarOps(pageNumber: _pageNumber),
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
                          "รับแจ้งเหตุ",
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
            automaticallyImplyLeading: true,
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
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                          widget.getInform.subTypeName,
                          const TextStyle(fontSize: 16, color: Colors.red),
                          widget.getInform.date,
                          const TextStyle(
                              fontSize: 15.0, color: Colors.black54),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(2),
                          child: const Text(
                            'รายละเอียด',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            widget.getInform.description,
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
                          widget.getInform.username,
                          const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                          '',
                          const TextStyle(fontSize: 15.0),
                        ),
                        textRow(
                          'สถานะ : ',
                          const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          widget.getInform.status,
                          const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                          '',
                          const TextStyle(fontSize: 15.0),
                        ),
                        Row(
                          children: [
                            const Text(
                              'ติดต่อ : ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () async => await launchUrlString(
                                  'tel:${widget.getInform.phoneNumberCallBack}'),
                              child: const Text(
                                'เบอร์โทรศัพท์',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () => _openMap(
                                    widget.getInform.latitude,
                                    widget.getInform.longitude),
                                child: const Text(
                                  'OpenMap',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 4,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.green.shade400),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.29),
                                      side: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.all(1),
                                        child: Center(
                                          child: Card(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: const Text(
                                                      'คุณต้องการที่จะรับการแจ้งเหตุนี้ ใช่หรือไม่',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration.none,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .double,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(1),
                                                        child: ElevatedButton(
                                                          style: const ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll<
                                                                          Color>(
                                                                      Colors
                                                                          .red)),
                                                          child: const Text(
                                                            'ไม่',
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(1),
                                                        child: ElevatedButton(
                                                          style:
                                                              const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors
                                                                        .green),
                                                          ),
                                                          child: const Text(
                                                            'ใช่',
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          onPressed: () async {
                                                            ReturnResponse res =
                                                                await _updateInform();
                                                            if (res.code !=
                                                                "0") {
                                                              Navigator.pop(
                                                                  context);
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                snackBarSos(
                                                                    context,
                                                                    Text(
                                                                      res.message,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    Colors.red),
                                                              );
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          100),
                                                                  () async {});
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const HomeOps(),
                                                                ),
                                                              );
                                                            } else {
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const HistoryPage(),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'รับการแจ้งเหตุ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: imagepages == []
                      ? null
                      : Wrap(
                          children: imagepages.map(
                            (imageone) {
                              return Container(
                                padding: const EdgeInsets.all(1.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(images: imageone),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        base64Decode(imageone),
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                ),
              ],
            ),
          ),
        );
}
