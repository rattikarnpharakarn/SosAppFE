import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';


class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  final PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: BottomBarBubble(
        items: [
          BottomBarItem(
            iconData: Icons.home,
            // label: 'Home',
          ),
          BottomBarItem(
            iconData: Icons.perm_contact_cal_outlined,
            // label: 'Chat',
          ),
          BottomBarItem(
            iconData: Icons.sos_outlined,
            // label: 'Notification',
          ),
          BottomBarItem(
            iconData: Icons.access_time_outlined,
            // label: 'Calendar',
          ),
          BottomBarItem(
            iconData: Icons.chat_outlined,
            // label: 'Setting',
          ),
        ],
        onSelect: (index) {
          // implement your select function here
        },
      ),
    );
  }
}
