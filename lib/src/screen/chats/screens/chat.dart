import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos/src/component/button_bar_ops.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/imageProfile.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:intl/intl.dart';

import 'package:sos/src/screen/chats/providers/messenger.dart';
import 'package:sos/src/screen/chats/screens/addRoomChat.dart';

import 'package:sos/src/model/messenger/response.dart';
import 'package:sos/src/provider/messenger/messengerService.dart';
import 'package:sos/src/screen/chats/screens/messenger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../common/LoadingPage.dart';

class ChatPage extends StatefulWidget {
  final IO.Socket? socket;

  const ChatPage({Key? key,  this.socket}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
    _getChatList();
  }

  // getChat
  List<GetChat> getChatList = [];
  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");

  _getChatList() async {
    await GetChatList().then(
          (value) {
        if (value.code == "0") {
          setState(
                () {
              for (var data in value.list) {
                //createdAt
                DateTime dt1 = DateTime.parse(data.createdAt);
                final String createdAt = newFormat.format(dt1);

                //updatedAt
                DateTime dt2 = DateTime.parse(data.updatedAt);
                final String updatedAt = newFormat.format(dt2);

                GetChat getChat = GetChat(
                  roomChatID: data.roomChatID,
                  roomName: data.roomName,
                  ownerId: data.ownerId,
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                  // deletedAT: deletedAT,
                  deleteBy: data.deleteBy,
                );
                getChatList.add(getChat);
              }
            },
          );
        }
      },
    ).onError((error, stackTrace) {
      // todo ต้องเพิ่ม popup
    });
  }

  late UserInfo userInfo;
  late String id;

  int _pageNumber = 4;

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

  @override
  Widget build(BuildContext context) =>
      isLoading == false
          ? const LoadingPage()
          : Scaffold(
        key: _key,
        bottomNavigationBar: userInfo.roleId == "2"
            ? Bottombar(pageNumber: _pageNumber)
            : userInfo.roleId == "3"
            ? ButtonBarOps(
          pageNumber: _pageNumber,
          socket: widget.socket!,
        )
            : null,
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
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          actions: [
            Container(),
          ],
        ),
        endDrawer: EndDrawer(),
        endDrawerEnableOpenDragGesture: false,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(0.1),
          child: Column(
            children: [
              for (GetChat m1 in getChatList) ...[
                ListTile(
                    onTap: () =>
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChangeNotifierProvider(
                                create: (context) => ChatsProvider(),
                                child: ChatsPage(
                                  username: userInfo.firstName +
                                      " " +
                                      userInfo.lastName,
                                  getChat: m1,
                                  userInfo: userInfo,
                                ),
                              ),
                        ),
                      ),
                    },
                    title: Text(m1.roomName),
                    leading: Image_Profile(
                      height: 43,
                      width: 43,
                      userId: m1.ownerId,
                    ) // todo ทำการดึงรูปภาพของคนที่สร้างห้อง
                ),
              ],
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Icon(Icons.add),
          tooltip: 'Add', // used by assistive technologies
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddRoomChatPage(
                        socket: widget.socket!,
                        roleId: userInfo.roleId,
                      )),
            );
          },
        ),
      );
}
