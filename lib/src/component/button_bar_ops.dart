import 'package:flutter/material.dart';
import 'package:sos/src/screen/chats/screens/chat.dart';

import '../screen/ops/history.dart';
import '../screen/ops/home.dart';
import '../screen/ops/hotline.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ButtonBarOps extends StatefulWidget {
  final IO.Socket socket;

  ButtonBarOps({
    super.key,
    required this.pageNumber,
    required this.socket,
  });

  int pageNumber;

  @override
  // ignore: no_logic_in_create_state
  State<ButtonBarOps> createState() => _ButtonBarOpsState();
}

class _ButtonBarOpsState extends State<ButtonBarOps> {
  final PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != widget.pageNumber) {
      setState(() {
        widget.pageNumber = index;
      });

      if (widget.pageNumber == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeOps(socket: widget.socket),
          ),
        );
      } else if (widget.pageNumber == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  HotlinePage(socket: widget.socket),
          ),
        );
      } else if (widget.pageNumber == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  HistoryPage(socket: widget.socket),
          ),
        );
      } else if (widget.pageNumber == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  ChatPage(socket: widget.socket),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: 'เบอร์โทรสารด่วน',
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ล่าสุด',
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'แชท',
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ],
        currentIndex: widget.pageNumber,
        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
