import 'package:flutter/material.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/imageProfile.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:intl/intl.dart';


import 'package:sos/src/screen/chats/screens/chat.dart';

import '../../../provider/accounts/userService.dart';
import 'package:sos/src/provider/messenger/messengerService.dart';

import '../../common/LoadingPage.dart';

class AddRoomChatPage extends StatefulWidget {
  const AddRoomChatPage({Key? key}) : super(key: key);

  @override
  State<AddRoomChatPage> createState() => _AddRoomChatPageState();
}

class _AddRoomChatPageState extends State<AddRoomChatPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController _valueSearchUserInputController =
      TextEditingController();
  final TextEditingController _nameRoomInputController =
      TextEditingController();

  bool isLoading = false;
  late List<bool> _isChecked;
  List<int> _userIdList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
  }

  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");

  List<GetUserList> _getUserList = [];

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
        }
        setState(() {
          _isChecked = List<bool>.filled(_getUserList.length + 1, false);
          isLoading = true;
        });
      },
    ).onError((error, stackTrace) {
      // todo ต้องเพิ่ม popup
      // print("======== error ========");
      // print(error);
      // print(stackTrace);
      // print("======== error ========");

      setState(() {
        isLoading = true;
      });
    });
  }

  _createRoomChat() async {
    CreateRoomChat(_nameRoomInputController.text.trim(), _userIdList);
  }

  int _pageNumber = 4;

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          key: _key,
          bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
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
                          "ห้องสนทนา",
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
          endDrawer: EndDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
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
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: const Text(
                                      "สร้างห้องแชท",
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
                                    if (_nameRoomInputController.text
                                        .trim()
                                        .isNotEmpty) {
                                      /*_searchUser(
                                          _nameRoomInputController.text.trim());*/
                                      await _createRoomChat();
                                      _nameRoomInputController.clear();
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.create_new_folder_outlined,
                                    color: Color(0xD3FF4646),
                                    size: 32,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            child: TextFormField(
                              controller: _nameRoomInputController,
                              decoration: const InputDecoration(
                                labelText: "ชื่อห้อง",
                                labelStyle: TextStyle(
                                    color: Color(0xD3FF4646),
                                    decorationStyle:
                                        TextDecorationStyle.double),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0x86FF4646)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xD3C02424),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              style: const TextStyle(color: Colors.black),
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
                                    onPressed: () {
                                      if (_valueSearchUserInputController.text
                                          .trim()
                                          .isNotEmpty) {
                                        _searchUser(
                                            _valueSearchUserInputController.text
                                                .trim());
                                        _valueSearchUserInputController.clear();
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
                  height: 420,
                  padding: const EdgeInsets.all(6),
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
              ],
            ),
          ),
        );
}
