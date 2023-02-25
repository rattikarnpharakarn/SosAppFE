import 'package:flutter/material.dart';
import 'package:sos/src/component/bottom_bar.dart';

class HotlinePage extends StatefulWidget {
  const HotlinePage({super.key});

  @override
  State<HotlinePage> createState() => HhotlinePageState();
}

class HhotlinePageState extends State<HotlinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        titleSpacing: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
      ),
      bottomNavigationBar: Bottombar(
        pageNumber: 1,
      ),
    );
  }
}
