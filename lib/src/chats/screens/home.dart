import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:sos/src/chats/model/message.dart';
import 'package:sos/src/chats/providers/home.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/model/messenger/response.dart';
import 'package:sos/src/screen/LoadingPage.dart';

class ChatsPage extends StatefulWidget {
  final String username;

  final UserInfo userInfo;
  final GetChat getChat;

  const ChatsPage({
    Key? key,
    required this.username,
    required this.userInfo,
    required this.getChat,
  }) : super(key: key);

  @override
  State<ChatsPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChatsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late IO.Socket _socket;

  final TextEditingController _messageInputController = TextEditingController();
  bool isLoading = false;

  _sendMessage() {
    _socket.emit(widget.getChat.roomChatID, {
      'message': _messageInputController.text.trim(),
      'sender': widget.userInfo.firstName + " " + widget.userInfo.lastName
    });
    _messageInputController.clear();
  }

  _connectSocket() {
    _socket.connect();
    _socket.on(widget.getChat.roomChatID,
      (data) {
        Provider.of<ChatsProvider>(context, listen: false).addNewMessage(
            Message.fromJson(data));
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _socket = IO.io(
      'http://10.0.2.2:3000/' + widget.getChat.roomChatID,
      IO.OptionBuilder().setTransports(['websocket'])
          .setQuery({
        'username': widget.userInfo.firstName + " " + widget.userInfo.lastName,
      }).build(),
    );
    _connectSocket();
    isLoading = true;
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
            // centerTitle: true,
            title: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Text(
                      widget.getChat.roomName,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22,
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
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      message.message,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      DateFormat('hh:mm a')
                                          .format(message.sentAt),
                                      style: TextStyle(fontSize: 10),
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
                      moodIcon(),
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
                            _sendMessage();
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
    print('Emoji Icon Pressed...');
  }

  void callAttachFile() {
    print('Attach File Icon Pressed...');
  }

  void callCamera() {
    print('Camera Icon Pressed...');
  }

  void callVoice() {
    print('Voice Icon Pressed...');
  }

  Widget camera() {
    return IconButton(
      icon: const Icon(
        Icons.photo_camera,
        color: Color(0xD3FF4646),
      ),
      onPressed: () => callCamera(),
    );
  }

  Widget sendMessage() {
    return IconButton(
      icon: const Icon(
        Icons.send,
        color: Color(0xD3FF4646),
      ),
      onPressed: () => _sendMessage(),
    );
  }

  Widget attachFile() {
    return IconButton(
      icon: const Icon(
        Icons.attach_file,
        color: Color(0xD3FF4646),
      ),
      onPressed: () => callAttachFile(),
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

  Widget containerMessageOwner(String name, message, imageProfile) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: 310,
                child: Text(
                  name,
                  style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: 310,
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          Image_NavBer(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget containerMessageOp(String name, message, imageProfile) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Image_NavBer(width: 40, height: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 310,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: 310,
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.dispose();
    _messageInputController.dispose();
    super.dispose();
  }
}
