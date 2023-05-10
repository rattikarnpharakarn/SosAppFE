import 'package:flutter/material.dart';
import 'package:sos/src/screen/chats/screens/chat.dart';
import 'package:sos/src/screen/user/sos.dart';

import '../screen/user/history.dart';
import '../screen/user/home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../screen/user/hotline.dart';

class Bottombar extends StatefulWidget {
  final IO.Socket? socket;

  Bottombar({
    super.key,
    required this.pageNumber,
    this.socket,
  });

  int pageNumber;

  @override
  // ignore: no_logic_in_create_state
  State<Bottombar> createState() => _ButtonbarState(pageNumber: pageNumber);
}

class _ButtonbarState extends State<Bottombar> {
  final PageController controller = PageController();

  _ButtonbarState({
    required this.pageNumber,
  });

  int pageNumber;

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != pageNumber) {
      setState(() {
        pageNumber = index;
      });

      if (pageNumber == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else if (pageNumber == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HotlinePage(),
          ),
        );
      } else if (pageNumber == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SosPage(),
          ),
        );
      } else if (pageNumber == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HistoryPage(),
          ),
        );
      } else if (pageNumber == 4) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(socket: widget.socket),
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
            icon: Icon(Icons.adjust_rounded),
            label: 'SOS',
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
        currentIndex: pageNumber,
        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
