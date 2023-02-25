import 'package:flutter/material.dart';
import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/endDrawer.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => NSosPageState();
}

class NSosPageState extends State<SosPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final int _pageNumber = 2;
  String _textArea = '';

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
        // centerTitle: false,
        title: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: const Text(
                  "แจ้งเหตุ",
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
      ),
      endDrawer: const EndDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  height: 400,
                  width: 400,
                  child: GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(5),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    child: Image.asset(
                                      'assets/images/sick.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print('เจ็บป่วย');
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: const Text(
                                'เจ็บป่วย',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 19.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    child: Image.asset(
                                      'assets/images/accident.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print('อุบัติเหตุ');
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: const Text(
                                'อุบัติเหตุ',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 19.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    child: Image.asset(
                                      'assets/images/building.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print('อาคาร/สถานที่');
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: const Text(
                                'อาคาร/สถานที่',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 19.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    child: Image.asset(
                                      'assets/images/others.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print('อื่นๆ');
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: const Text(
                                'อื่นๆ',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 19.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        onChanged: (value) => setState(() {
                          _textArea = value;
                          print(_textArea);
                        }),
                        maxLines: 6,
                        maxLength: 1000, //or null
                        decoration: const InputDecoration.collapsed(
                          hintText: "คำอธิบายเพิ่มเติม",
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: SizedBox(
                      width: 312.48,
                      height: 63.4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.29),
                              side: const BorderSide(
                                  width: 3, color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print('Test ElvevatedButton');
                        },
                        child: const Text(
                          "ถัดไป",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
