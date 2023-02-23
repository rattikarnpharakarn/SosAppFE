import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sos/src/screen/home.dart';
import 'package:sos/src/screen/test.dart';

class Bottombar extends StatefulWidget {
  Bottombar({
    super.key,
    required this.pageNumber,
  });
  int pageNumber;

  @override
  // ignore: no_logic_in_create_state
  State<Bottombar> createState() => _BottombarState(pageNumber: pageNumber);
}

class _BottombarState extends State<Bottombar> {
  final PageController controller = PageController();
  _BottombarState({
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else if (pageNumber == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestPage(),
          ),
        );
      } else if (pageNumber == 2) {
      } else if (pageNumber == 3) {
      } else if (pageNumber == 4) {}
    }
  }

  // Home(),
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
            backgroundColor: Color.fromARGB(255, 250, 92, 92),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: 'เบอร์โทรสารด่วน',
            backgroundColor: Color.fromARGB(255, 250, 92, 92),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust_rounded),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ล่าสุด',
            backgroundColor: Color.fromARGB(255, 250, 92, 92),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'แชท',
            backgroundColor: Color.fromARGB(255, 250, 92, 92),
          ),
        ],
        currentIndex: pageNumber,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 250, 92, 92),
        onTap: _onItemTapped,
      ),
    );
  }
}
