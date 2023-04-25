import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos/src/chats/providers/home.dart';
import 'package:sos/src/chats/screens/home.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/screen/LoadingPage.dart';
import 'package:intl/intl.dart';

// import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../provider/accounts/userService.dart';
import 'package:sos/src/model/messenger/response.dart';
import 'package:sos/src/provider/messenger/messengerService.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

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

                //deletedAT
                // String deletedAT = '';
                // if (data.deletedAT != null){
                //   DateTime dt3 = DateTime.parse(data.deletedAT);
                //   String deletedAT = newFormat.format(dt3);
                // }
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
          setState(() {
            isLoading = true;
          });
        }
      },
    ).onError((error, stackTrace) {
      // todo ต้องเพิ่ม popup
      setState(() {
        isLoading = true;
      });
    });
  }

  late UserInfo userInfo;
  late String id;

  _getUserProfile() async {
    UserInfo data = await GetUserProfile();
    setState(() {
      userInfo = data;
    });
  }

  int _pageNumber = 4;

  _socket(){

  }

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
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            actions: [
              Container(),
            ],
          ),
          endDrawer: EndDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: Container(
            padding: const EdgeInsets.all(0.1),
            child: Column(
              children: [
                for (GetChat m1 in getChatList) ...[
                  ListTile(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (context) => ChatsProvider(),
                            child: ChatsPage(
                              username:
                                  userInfo.firstName + " " + userInfo.lastName,
                              getChat: m1,
                              userInfo: userInfo,
                            ),
                          ),
                        ),
                      ),
                    },
                    title: Text(m1.roomName),
                    // todo RoomName โดยการดึก API
                    leading: Image_NavBer(
                        height: 40,
                        width: 40), // todo ทำการดึงรูปภาพของคนที่สร้างห้อง
                  ),
                ],
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Icon(Icons.add),
            tooltip: 'Add', // used by assistive technologies
            onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Container(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(maxHeight: 600),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: const Text(
                                "ค้นหารายชื่อเพิ่อเพิ่มไปยังแชท",
                                style: TextStyle(
                                  fontSize: 18,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "ชื่อ เบอร์โทร หรือ ที่ทำงาน",
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
                              onChanged: (value) => setState(
                                () {
                                  if (value.length >= 3) {}
                                },
                              ),
                            ),

                            // todo ทำการ ดึก API จาก Account มาแสดง
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
}

// class ChatPage1 extends StatefulWidget {
//   const ChatPage1({Key? key}) : super(key: key);
//
//   @override
//   State<ChatPage1> createState() => _ChatPage1State();
// }
//
// String url = wsMessenger;
//
// class _ChatPage1State extends State<ChatPage1> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _getUserProfile();
//     _socket = IO.io(
//       '${url}',
//       IO.OptionBuilder().setTransports(['websocket']).build(),
//     );
//     _connectSocket();
//   }
//
//   // _socket
//   late IO.Socket _socket;
//
//   _sendMessage() {
//     _socket.emit('message', {
//       'message': _controller.text.trim(),
//     });
//     _controller.clear();
//   }
//
//   _connectSocket() {
//     _socket.onConnect((data) => print('Connection established'));
//     _socket.onConnectError((data) => print('Connect Error: $data'));
//     _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
//     // _socket.on(
//     //   'message',
//     //       (data) => Provider.of<HomeProvider>(context, listen: false).addNewMessage(
//     //     Message.fromJson(data),
//     //   ),
//     // );
//   }
//
//   bool isLoading = false;
//
//   // late IOWebSocketChannel channel;
//   late UserInfo userInfo;
//   late String id;
//   List<String> messagesList = [];
//
//   _getUserProfile() async {
//     UserInfo data = await GetUserProfile();
//     setState(() {
//       userInfo = data;
//       isLoading = true;
//     });
//   }
//
//   int _pageNumber = 4;
//
//   @override
//   Widget build(BuildContext context) => isLoading == false
//       ? const LoadingPage()
//       : Scaffold(
//           key: _key,
//           bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
//           // appBar: NavbarPages(),
//           appBar: AppBar(
//             // toolbarHeight: 0,
//             backgroundColor: const Color.fromARGB(255, 248, 0, 0),
//             elevation: 0,
//             // centerTitle: true,
//             title: Container(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
//                     child: const Text(
//                       "แชท 1",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         fontSize: 22,
//                         decorationStyle: TextDecorationStyle.solid,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: const CircleBorder(),
//                         backgroundColor:
//                             const Color.fromARGB(255, 255, 255, 255),
//                       ),
//                       child: Image_NavBer(height: 40, width: 40),
//                       onPressed: () {
//                         _key.currentState!.openEndDrawer();
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             automaticallyImplyLeading: true,
//             titleSpacing: 0,
//             actions: [
//               Container(),
//             ],
//           ),
//           endDrawer: EndDrawer(),
//           endDrawerEnableOpenDragGesture: false,
//           body: Container(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 // Expanded(
//                 //   child: StreamBuilder(
//                 //     stream: channel.stream,
//                 //     builder:(context, snapshot) {
//                 //         if (snapshot.hasData){
//                 //           print(snapshot.data.toString());
//                 //           messagesList.add(snapshot.data);
//                 //         }
//                 //       return getMessageList();
//                 //     }
//                 //   ),
//                 // ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: SizedBox(
//                     child: Row(
//                       children: [
//                         moodIcon(),
//                         attachFile(),
//                         camera(),
//                         Expanded(
//                           child: TextField(
//                             controller: _controller,
//                             decoration: const InputDecoration(
//                                 hintText: "Message",
//                                 hintStyle: TextStyle(
//                                   color: Color(0xD3FF4646),
//                                 ),
//                                 border: InputBorder.none),
//                           ),
//                         ),
//                         sendMessage(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//
//   // void _sendMessage() {
//   //   if (_controller.text.isNotEmpty) {
//   //     channel.sink.add(_controller.text);
//   //     _controller.text = '';
//   //   }
//   // }
//
//   ListView getMessageList() {
//     List<Widget> listWidget = [];
//     for (String message in messagesList) {
//       listWidget.add(
//         Container(
//           padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
//           child: containerMessageOwner(
//               userInfo.firstName + ' ' + userInfo.lastName,
//               message,
//               userInfo.imageProfile),
//         ),
//       );
//     }
//
//     return ListView(
//       reverse: true,
//       children: listWidget,
//     );
//   }
//
//   // @override
//   // void dispose() {
//   //   _controller.dispose();
//   //   channel.sink.close();
//   //   super.dispose();
//   // }
//
//   void callEmoji() {
//     print('Emoji Icon Pressed...');
//   }
//
//   void callAttachFile() {
//     print('Attach File Icon Pressed...');
//   }
//
//   void callCamera() {
//     print('Camera Icon Pressed...');
//   }
//
//   void callVoice() {
//     print('Voice Icon Pressed...');
//   }
//
//   Widget camera() {
//     return IconButton(
//       icon: const Icon(
//         Icons.photo_camera,
//         color: Color(0xD3FF4646),
//       ),
//       onPressed: () => callCamera(),
//     );
//   }
//
//   Widget sendMessage() {
//     return IconButton(
//       icon: const Icon(
//         Icons.send,
//         color: Color(0xD3FF4646),
//       ),
//       onPressed: () => _sendMessage(),
//     );
//   }
//
//   Widget attachFile() {
//     return IconButton(
//       icon: const Icon(
//         Icons.attach_file,
//         color: Color(0xD3FF4646),
//       ),
//       onPressed: () => callAttachFile(),
//     );
//   }
//
//   Widget moodIcon() {
//     return IconButton(
//         icon: const Icon(
//           Icons.mood,
//           color: Color(0xD3FF4646),
//         ),
//         onPressed: () => callEmoji());
//   }
//
//   //name
//   //message
//   //imageProfile
//   Widget containerMessageOwner(String name, message, imageProfile) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//       child: Row(
//         children: [
//           Spacer(),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 alignment: Alignment.bottomRight,
//                 padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                 width: 310,
//                 child: Text(
//                   name,
//                   style: TextStyle(fontSize: 10, color: Colors.blueGrey),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.bottomRight,
//                 padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                 width: 310,
//                 child: Text(
//                   message,
//                   style: TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//           Image_NavBer(width: 40, height: 40),
//         ],
//       ),
//     );
//   }
//
//   Widget containerMessageOp(String name, message, imageProfile) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//       child: Row(
//         children: [
//           Image_NavBer(width: 40, height: 40),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 width: 310,
//                 alignment: Alignment.topLeft,
//                 padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                 child: Text(
//                   name,
//                   style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.topLeft,
//                 padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                 width: 310,
//                 child: Text(
//                   message,
//                   style: const TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
