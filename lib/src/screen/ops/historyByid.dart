import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/emergency/inform.dart';
import 'package:sos/src/provider/messenger/messengerService.dart';
import 'package:sos/src/screen/chats/screens/chat.dart';
import 'package:sos/src/screen/common/LoadingPage.dart';
import 'package:sos/src/screen/common/detailImage.dart';
import 'package:sos/src/screen/user/sos.dart';
import 'package:sos/src/sharedInfo/user.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../component/button_bar_ops.dart';
import 'history.dart';

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

  _createRoomChat() async {
    String roomName =
        widget.getInform.subTypeName + " : " + widget.getInform.description;

    List<int> _userIdList = [];
    _userIdList.add(int.parse(getInformById.userId!));

    if (getInformById.status == "รับเรื่องการแจ้งเหตุแล้ว") {
      await _updateInform(2, "Y");
    } else if (getInformById.status == "กำลังดำเนินงาน") {
      await _updateInform(3, "Y");
    } else if (getInformById.status == "ดำเนินงานเสร็จสิ้น") {
      await _updateInform(4, "Y");
    }

    await CreateRoomChat(roomName, _userIdList);
    await _navigatorChatPage();
  }

  _navigatorChatPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatPage(),
      ),
    );
  }

  final int _pageNumber = 2;

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

  _updateInform(status, statusChat) async {
    bool statusChatUpdate = false;
    if (statusChat == "Y") {
      // เปลี่ยนเป็นสร้างห้องนี้แล้ว
      statusChatUpdate = true;
    } else if (statusChat == "D") {
      // ค่าคงเดิม
      statusChatUpdate = widget.getInform.statusChat;
    }

    String opsIdStr = await getUserIDSF();
    var infomrId = widget.getInform.id;
    var opsId = int.parse(opsIdStr);
    UpdateInform req = UpdateInform(
      opsID: opsId,
      status: status,
      statusChat: statusChatUpdate,
    );
    await UpdateInformOps(req, infomrId);

    if (statusChat == "D") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        ),
      );
    }
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
            padding: const EdgeInsets.all(8),
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
                          'อัพเดทเมื่อ : ${widget.getInform.updateDate}',
                          TextStyle(fontSize: 15.0, color: Colors.black54),
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
                          TextStyle(fontSize: 15.0),
                        ),
                        textRow(
                          'สถานะ : ',
                          const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          getInformById.status!,
                          TextStyle(
                            fontSize: 16,
                            color: getInformById.status ==
                                    "รับเรื่องการแจ้งเหตุแล้ว"
                                ? Colors.red
                                : getInformById.status == "กำลังดำเนินงาน"
                                    ? Colors.orange
                                    : getInformById.status ==
                                            "ดำเนินงานเสร็จสิ้น"
                                        ? Colors.green
                                        : null,
                          ),
                          '',
                          TextStyle(fontSize: 15.0),
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
                            const Spacer(
                              flex: 4,
                            ),
                            !widget.getInform.statusChat
                                ? InkWell(
                                    onTap: () => _createRoomChat(),
                                    child: const Text(
                                      'สร้างห้องสนทนา',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const Text('สร้างห้องสนทนาแล้ว',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black54)),
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
                              child:
                                  getInformById.status ==
                                          "รับเรื่องการแจ้งเหตุแล้ว"
                                      ? ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red.shade400),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.29),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(1),
                                                  child: Center(
                                                    child: Card(
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: const Text(
                                                                'คุณต้องการที่จะอัพเดทสถานะ ใช่หรือไม่',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  decorationStyle:
                                                                      TextDecorationStyle
                                                                          .double,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(1),
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: const ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStatePropertyAll<Color>(Colors.red)),
                                                                    child:
                                                                        const Text(
                                                                      'ไม่',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
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
                                                                  child:
                                                                      ElevatedButton(
                                                                    style:
                                                                        const ButtonStyle(
                                                                      backgroundColor: MaterialStatePropertyAll<
                                                                              Color>(
                                                                          Colors
                                                                              .green),
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'ใช่',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await _updateInform(
                                                                          3,
                                                                          "D");
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
                                            'อัพเดทสถานะ ดำเนินงาน',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : getInformById.status ==
                                              "ดำเนินงานเสร็จสิ้น"
                                          ? null
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.orange.shade400),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.29),
                                                    side: const BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () async {
                                                showCupertinoModalPopup<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      child: Center(
                                                        child: Card(
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child:
                                                                      const Text(
                                                                    'คุณต้องการที่จะอัพเดทสถานะ ใช่หรือไม่',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      decorationStyle:
                                                                          TextDecorationStyle
                                                                              .double,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              1),
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: const ButtonStyle(
                                                                            backgroundColor:
                                                                                MaterialStatePropertyAll<Color>(Colors.red)),
                                                                        child:
                                                                            const Text(
                                                                          'ไม่',
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              1),
                                                                      child:
                                                                          ElevatedButton(
                                                                        style:
                                                                            const ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStatePropertyAll<Color>(Colors.green),
                                                                        ),
                                                                        child:
                                                                            const Text(
                                                                          'ใช่',
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        onPressed: () async => await _updateInform(
                                                                            4,
                                                                            "D"),
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
                                                'อัพเดทสถานะ จบการทำงาน',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline,
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
