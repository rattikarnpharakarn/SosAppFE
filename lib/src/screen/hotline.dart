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
        title: Container(
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: const Text(
            'Hotline',
            style: TextStyle(fontSize: 24),
          ),
        ),
        // toolbarHeight: 50,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        titleSpacing: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
      ),
      body: SingleChildScrollView(),
      bottomNavigationBar: Bottombar(
        pageNumber: 1,
      ),
    );
  }
}
