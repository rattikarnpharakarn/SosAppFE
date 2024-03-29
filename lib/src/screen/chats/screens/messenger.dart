import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/button_bar_ops.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/model/messenger/response.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/common/notificationApp.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/provider/messenger/messengerService.dart';
import 'package:sos/src/screen/chats/model/message.dart';
import 'package:sos/src/screen/chats/providers/messenger.dart';
import 'package:sos/src/screen/chats/screens/members.dart';
import 'package:sos/src/screen/common/detailImage.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';

import '../../common/LoadingPage.dart';

class MessengerPage extends StatefulWidget {
  final String username;

  final UserInfo userInfo;
  final GetChat getChat;

  const MessengerPage({
    Key? key,
    required this.username,
    required this.userInfo,
    required this.getChat,
  }) : super(key: key);

  @override
  State<MessengerPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MessengerPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late IO.Socket _socket;

  final TextEditingController _messageInputController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _socket = IO.io(
      urlWsMessenger + widget.getChat.roomChatID,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({
        'username': widget.userInfo.firstName + " " + widget.userInfo.lastName,
      }).build(),
    );
    _connectSocket();
  }

  _connectSocket() async {
    _socket.connect();
    _socket.on(widget.getChat.roomChatID, (data) {

      Provider.of<ChatsProvider>(context, listen: false)
          .addNewMessage(Message.fromJson(data) , true);
    });
    await _getGetMessageById(widget.getChat.roomChatID);
    isLoading = true;
  }

  _sendMessage(String image) async {
    _socket.emit(widget.getChat.roomChatID, {
      'message': _messageInputController.text.trim(),
      'sender': widget.userInfo.firstName + " " + widget.userInfo.lastName,
      'image': image,
    });
    PostMessage(
        widget.getChat.roomChatID, _messageInputController.text.trim(), image);
    _messageInputController.clear();
  }

  var newFormat = DateFormat("dd-MM-yyyy HH:mm น.");
  List<GetMessageList> geMessageList = [];

  _getGetMessageById(roomChatId) async {
    await _getUserProfile();
    await GetMessageById(roomChatId).then(
      (value) {
        if (value.code == "0") {
          setState(
            () {
              Future.forEach(value.list, (data) async {
                //createdAt
                DateTime sentAt = DateTime.parse(data.updatedAt);
                final String createdAt = newFormat.format(sentAt);

                //
                //updatedAt
                DateTime dt2 = DateTime.parse(data.updatedAt);
                final String updatedAt = newFormat.format(dt2);

                GetMessageList getChat = GetMessageList(
                  id: data.id,
                  roomChatID: data.roomChatID,
                  message: data.message,
                  image: data.image,
                  senderUserId: data.senderUserId,
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                );

                UserInfo userByid = await GetUserProfileById(data.senderUserId);

                String image = "";
                await GetImageByMessageId(data.id).then((value) {
                  if (value.code == "0") {
                    Future.forEach(value.list, (m1) async {
                      image = m1.image;
                    });
                  }
                });

                String senderUsername =
                    '${userByid.firstName} ${userByid.lastName}';
                Message msg = Message(
                    message: getChat.message,
                    image: image,
                    sentAt: sentAt,
                    senderUsername: senderUsername);
                Provider.of<ChatsProvider>(context, listen: false)
                    .addNewMessage(msg, false);

                // geMessageList.add(getChat);
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
                    child: TextButton(
                      child: Text(
                        widget.getChat.roomName,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MembersPage(
                              getChat: widget.getChat,
                            ),
                          ),
                        );
                      },
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
            // leading: IconButton(
            //   onPressed: () async {
            //     await _disconnectSocket();
            //   },
            //   icon: Icon(Icons.arrow_back),
            // ),
            titleSpacing: 0,
            actions: [
              Container(),
            ],
          ),
          endDrawer: EndDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: Column(
            children: [
              Expanded(
                child: Consumer<ChatsProvider>(
                  builder: (_, provider, __) => ListView.separated(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    addSemanticIndexes: false,
                    reverse: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final message = provider.messages[index];
                      return Wrap(
                        alignment: message.senderUsername == widget.username
                            ? WrapAlignment.end
                            : WrapAlignment.start,
                        children: [
                          Card(
                            color: message.senderUsername == widget.username
                                ? Theme.of(context).primaryColorLight
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                    message.senderUsername == widget.username
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      message.senderUsername,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  message.image == ""
                                      ? Container(
                                          padding: EdgeInsets.all(1.0),
                                          child: Text(
                                            message.message,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      : TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        images: message.image),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(
                                                base64Decode(message.image),
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      DateFormat('dd-MM-yyyy HH:mm น.')
                                          .format(message.sentAt),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: provider.messages.length,
                  ),
                ),
              ),
              Container(
                // decoration: BoxDecoration(
                //   color: Colors.grey.shade200,
                // ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      // moodIcon(),
                      attachFile(),
                      camera(),
                      Expanded(
                        child: TextField(
                          controller: _messageInputController,
                          decoration: const InputDecoration(
                              hintText: "Message",
                              hintStyle: TextStyle(
                                color: Color(0xD3FF4646),
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_messageInputController.text.trim().isNotEmpty) {
                            _sendMessage("");
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color(0xD3FF4646),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );

  void callEmoji() {

  }

  final ImagePicker imgPicker = ImagePicker();
  String imagePath = "";
  String selectImage = "";

  void callImageFile() async {
    openImage("Gallery");
    print('Attach File Icon Pressed...');
  }

  void callCamera() async {
    openImage("Camera");
    print('Camera Icon Pressed...');
  }

  void openImage(String type) async {
    try {
      ImageSource source;
      if (type == "Camera") {
        source = ImageSource.camera;
      } else if (type == "Gallery") {
        source = ImageSource.gallery;
      } else {
        throw Exception("ไม่สามารถใช้งานในขณะนี้");
      }
      var pickedFile = await imgPicker.pickImage(source: source);
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        File imageFile = File(imagePath);
        Uint8List imageBytes = await imageFile.readAsBytes();
        String base64string = base64.encode(imageBytes);

        Uint8List decodedBytes = base64.decode(base64string);

        String selectImage = base64Encode(decodedBytes);
        await _sendMessage(selectImage);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarSos(
            context,
            Text(
              e.toString(),
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            Colors.white),
      );
    }
  }

  Widget camera() {
    return IconButton(
      icon: const Icon(
        Icons.photo_camera,
        color: Color(0xD3FF4646),
      ),
      onPressed: () async => callCamera(),
    );
  }

  Widget attachFile() {
    return IconButton(
      icon: const Icon(
        Icons.image,
        color: Color(0xD3FF4646),
      ),
      onPressed: () => callImageFile(),
    );
  }

  Widget sendMessage() {
    return IconButton(
      icon: const Icon(
        Icons.send,
        color: Color(0xD3FF4646),
      ),
      onPressed: () => _sendMessage(""),
    );
  }



  Widget moodIcon() {
    return IconButton(
        icon: const Icon(
          Icons.mood,
          color: Color(0xD3FF4646),
        ),
        onPressed: () => callEmoji());
  }

  @override
  void dispose() {
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.dispose();
    _messageInputController.dispose();
    super.dispose();
  }
}
