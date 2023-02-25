import 'package:flutter/material.dart';
import 'package:sos/src/component/endDrawer.dart';

class NavbarPages extends AppBar {
  NavbarPages({
    super.key,
  });

  @override
  State<NavbarPages> createState() => _NavbarPagesState();
}

class _NavbarPagesState extends State<NavbarPages> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: _key,
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
                  padding: const EdgeInsets.all(1),
                  child: const Text(
                    "Hi Gig.",
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
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        'assets/images/profile.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
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
    );
  }
}
