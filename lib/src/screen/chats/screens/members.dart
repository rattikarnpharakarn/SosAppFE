import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/button_bar_ops.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/imageProfile.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/model/messenger/response.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/messenger/messengerService.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';

import '../../common/LoadingPage.dart';

class MembersPage extends StatefulWidget {
  final GetChat getChat;

  const MembersPage({
    Key? key,
    required this.getChat,
  }) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController _valueSearchUserInputController =
      TextEditingController();

  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");
  List<GetUserList> _getUserList = [];
  late List<bool> _isChecked;
  late List<int> _userIdList = [];
  late bool _isCheckSearch = false;
  late UserInfo userInfo;

  @override
  void initState() {
    super.initState();
    _getMembersRoomChat(widget.getChat.roomChatID);
  }

  List<GetMemberRoomChatShow> _getMemberRoomChatShow = [];

  _getMembersRoomChat(roomChatId) async {
    await _getUserProfile();
    await GetMembersRoomChat(roomChatId).then(
      (value) {
        if (value.code == "0") {
          setState(
            () {
              Future.forEach(
                value.memberRoomChat,
                (data) async {
                  UserInfo userByid = await GetUserProfileById(data.userId);

                  GetMemberRoomChatShow getMemberRoomChat =
                      GetMemberRoomChatShow(
                    userId: data.userId,
                    firstName: userByid.firstName,
                    lastName: userByid.lastName,
                  );

                  _getMemberRoomChatShow.add(getMemberRoomChat);
                },
              );
            },
          );
        }

        Future.delayed(Duration(milliseconds: 1000), () async {
          setState(() {
            isLoading = true;
          });
        });
      },
    ).onError((error, stackTrace) {
      setState(() {
        isLoading = true;
      });
    });
  }

  _searchUser(value) async {
    await GetSearchUser(value).then(
      (value) {
        if (value.code == "0") {
          _getUserList = [];
          setState(
            () {
              Future.forEach(value.list, (data) async {
                DateTime d1 = DateTime.parse(data.birthday);
                final String birthday = newFormat.format(d1);

                GetUserList getUser = GetUserList(
                  id: data.id,
                  phoneNumber: data.phoneNumber,
                  firstName: data.firstName,
                  lastName: data.lastName,
                  email: data.email,
                  birthday: birthday,
                  gender: data.gender,
                  imageProfile: data.imageProfile,
                  // workplace: data.workplace,
                  textIDCard: data.textIDCard,
                  pathImage: data.pathImage,
                  address: data.address,
                  subDistrict: data.subDistrict,
                  district: data.district,
                  province: data.province,
                  postalCode: data.postalCode,
                  country: data.country,
                );
                _getUserList.add(getUser);
              });
            },
          );

          if (_getUserList.isEmpty) {
            setState(() {
              _isCheckSearch = true;
            });
          }
        }
        setState(() {
          _isChecked = List<bool>.filled(_getUserList.length + 1, false);
          isLoading = true;
        });
      },
    ).onError((error, stackTrace) {
      // todo ต้องเพิ่ม popup
      print("======== error ========");
      print(error);
      print(stackTrace);
      print("======== error ========");

      setState(() {
        isLoading = true;
      });
    });
  }

  _getUserProfile() async {
    UserInfo data = await GetUserProfile();
    setState(() {
      if (data.roleId == "2") {
        _pageNumber = 4;
      } else if (data.roleId == "3") {
        _pageNumber = 3;
      }

      userInfo = data;
      isLoading = true;
    });
  }

  _joinRoomChat(roomChatID) async {
    JoinRoomChat(roomChatID, _userIdList);
  }

  int _pageNumber = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          key: _key,
          bottomNavigationBar: userInfo.roleId == "2"
              ? Bottombar(pageNumber: _pageNumber)
              : userInfo.roleId == "3"
                  ? ButtonBarOps(
                      pageNumber: _pageNumber,
                    )
                  : null,
          appBar: AppBar(
            // toolbarHeight: 0,
            backgroundColor: const Color.fromARGB(255, 248, 0, 0),
            elevation: 0,
            // centerTitle: true,
            title: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      widget.getChat.roomName,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
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
            padding: const EdgeInsets.all(0.1),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 13, 13, 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            child: SafeArea(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: const Text(
                                        "เพิ่มสมาชิกในห้องแชท",
                                        style: TextStyle(
                                          fontSize: 18,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String msg = '';
                                      if (_userIdList.length == 0) {
                                        msg =
                                            'กรุณาค้นหาผู้ใช้งานก่อนที่จะเพิ่มเข้าห้องแชท';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBarSos(
                                            context,
                                            Text(
                                              msg,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            Colors.white,
                                          ),
                                        );
                                      } else {
                                        _joinRoomChat(
                                            widget.getChat.roomChatID);
                                        msg =
                                            'เพิ่มผู้ใช้งานเข้าในห้องแชทเรียบร้อนแล้ว';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBarSos(
                                            context,
                                            Text(
                                              msg,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            Colors.white,
                                          ),
                                        );
                                        Navigator.pop(
                                          context,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.group_add_outlined,
                                      color: Color(0xD3FF4646),
                                      size: 32,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            child: SafeArea(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          _valueSearchUserInputController,
                                      decoration: const InputDecoration(
                                        labelText:
                                            "ชื่อ เบอร์โทร หรือ ที่ทำงาน",
                                        labelStyle: TextStyle(
                                            color: Color(0xD3FF4646),
                                            decorationStyle:
                                                TextDecorationStyle.double),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0x86FF4646)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xD3C02424),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (_valueSearchUserInputController.text
                                          .trim()
                                          .isNotEmpty) {
                                        await _searchUser(
                                            _valueSearchUserInputController.text
                                                .trim());
                                        if (_isCheckSearch) {
                                          String msg = 'ไม่พบผู้ใช้งานคนนี้';
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            snackBarSos(
                                              context,
                                              Text(
                                                msg,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              Colors.white,
                                            ),
                                          );
                                        } else {
                                          _valueSearchUserInputController
                                              .clear();
                                        }
                                      } else if (_valueSearchUserInputController
                                              .text.length <
                                          3) {
                                        String msg =
                                            'ตัวอักษรต้องไม่ต่ำกว่า 3 ตัวขึ้นไป';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBarSos(
                                            context,
                                            Text(
                                              msg,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            Colors.white,
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.search_outlined,
                                      color: Color(0xD3FF4646),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 5, 13, 0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(2),
                    itemCount: _getUserList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CheckboxListTile(
                                onChanged: (value) {
                                  setState(
                                    () {
                                      if (_isChecked[index] == true) {
                                        var id =
                                            int.parse(_getUserList[index].id);
                                        _userIdList.removeWhere((val) {
                                          return val == id;
                                        });
                                        _isChecked[index] = false;
                                      } else {
                                        var id =
                                            int.parse(_getUserList[index].id);
                                        _userIdList.add(id);
                                        _isChecked[index] = true;
                                      }
                                    },
                                  );
                                },
                                value: _isChecked[index],
                                title: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Image_Profile(
                                        height: 50,
                                        width: 50,
                                        userId: _getUserList[index].id,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: Text(
                                        "${_getUserList[index].firstName} ${_getUserList[index].lastName}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //สมาชิกในห้อง
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 5, 13, 13),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(13, 5, 13, 0),
                            child: const Text(
                              "สมาชิกในห้องแชท",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          for (GetMemberRoomChatShow m1
                              in _getMemberRoomChatShow) ...[
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Image_Profile(
                                    height: 50,
                                    width: 50,
                                    userId: m1.userId.toString(),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(
                                    m1.firstName + " " + m1.lastName,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

  @override
  void dispose() {
    super.dispose();
  }
}
