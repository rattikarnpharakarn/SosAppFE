import 'package:flutter/material.dart';

class UploadIDCard extends StatefulWidget {
  const UploadIDCard({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);

  final String username;
  final String password;

  @override
  State<UploadIDCard> createState() => _UploadIDCardState();
}

class _UploadIDCardState extends State<UploadIDCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
        centerTitle: false,
        title: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: const Text(
                  "แก้ไขข้อมูลสำหรับการยืนยันตัวตน",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        actions: [
          Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text("Test"),
        ),
      ),
    );
  }
}
