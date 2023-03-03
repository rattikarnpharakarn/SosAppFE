import 'package:flutter/material.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/image_navBer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _pageNumber = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Image_NavBer(),
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
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatPage1(),
                  ),
                ),
              },
              title: const Text('Name 1'),
              leading: Image_NavBer(),
            ),
            ListTile(
              onTap: () => {
                print('2'),
              },
              title: const Text('Name 2'),
              leading: Image_NavBer(),
            ),
            ListTile(
              onTap: () => {
                print('3'),
              },
              title: const Text('Name 3'),
              leading: Image_NavBer(),
            ),
            ListTile(
              onTap: () => {
                print('4'),
              },
              title: const Text('Name 4'),
              leading: Image_NavBer(),
            ),
            ListTile(
              onTap: () => {
                print('5'),
              },
              title: const Text('Name 5'),
              leading: Image_NavBer(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage1 extends StatefulWidget {
  const ChatPage1({Key? key}) : super(key: key);

  @override
  State<ChatPage1> createState() => _ChatPage1State();
}

class _ChatPage1State extends State<ChatPage1> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _pageNumber = 4;

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
      onPressed: () => callCamera(),
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

  //name
  //message
  //imageProfile
  Widget containerMessageOwner(String name, message, imageProfile) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.zero,
                width: 310,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.zero,
                width: 310,
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          Image_NavBer(),
        ],
      ),
    );
  }

  Widget containerMessageOp(String name, message, imageProfile) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Image_NavBer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 310,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.zero,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.zero,
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
      // appBar: NavbarPages(),
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
                child: const Text(
                  "แชท 1",
                  style: TextStyle(
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
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Image_NavBer(),
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: true,
                children: [
                  containerMessageOwner('Chirapon', 'ข้อความ', ''),
                  containerMessageOp('ร.ต.ท.', 'ข้อความ', ''),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                child: Row(
                  children: [
                    moodIcon(),
                    attachFile(),
                    camera(),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: TextStyle(
                              color: Color(0xD3FF4646),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    sendMessage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
