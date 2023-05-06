import 'package:flutter/material.dart';
import 'package:sos/src/screen/chats/screens/chat.dart';

import '../screen/ops/history.dart';
import '../screen/ops/home.dart';
import '../screen/ops/hotline.dart';

class ButtonBarOps extends StatefulWidget {
  ButtonBarOps({
    super.key,
    required this.pageNumber,
  });
  int pageNumber;

  @override
  // ignore: no_logic_in_create_state
  State<ButtonBarOps> createState() => _ButtonBarOpsState(pageNumber: pageNumber);
}

class _ButtonBarOpsState extends State<ButtonBarOps> {
  final PageController controller = PageController();
  _ButtonBarOpsState({
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
            builder: (context) => const HomeOps(),
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
            builder: (context) => const HistoryPage(),
          ),
        );
      } else if (pageNumber == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatPage(),
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
        currentIndex: pageNumber,
        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}

