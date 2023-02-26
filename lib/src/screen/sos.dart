import 'package:flutter/material.dart';

import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/sosComponent.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => NSosPageState();
}

class NSosPageState extends State<SosPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final int _pageNumber = 2;
  String _textArea = '';

  int onSelect = 0;

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
                      TextButton(
                        autofocus: false,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: onSelect == 1 || onSelect == 0
                            ? SosComponent(
                                images: 'assets/images/sick.png',
                                title: 'เจ็บป่วย',
                                isDisabledButton: true,
                              )
                            : SosComponent(
                                images: 'assets/images/sick.png',
                                title: 'เจ็บป่วย',
                              ),
                        onPressed: () {
                          print('เจ็บป่วย');
                          setState(() {
                            if (onSelect == 1) {
                              onSelect = 0;
                            } else {
                              onSelect = 1;
                            }
                          });
                        },
                      ),
                      TextButton(
                        autofocus: false,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: onSelect == 2 || onSelect == 0
                            ? SosComponent(
                                images: 'assets/images/accident.png',
                                title: 'อุบัติเหตุ',
                                isDisabledButton: true,
                              )
                            : SosComponent(
                                images: 'assets/images/accident.png',
                                title: 'อุบัติเหตุ',
                              ),
                        onPressed: () {
                          print('อุบัติเหตุ');
                          setState(() {
                            if (onSelect == 2) {
                              onSelect = 0;
                            } else {
                              onSelect = 2;
                            }
                          });
                        },
                      ),
                      TextButton(
                        autofocus: false,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: onSelect == 3 || onSelect == 0
                            ? SosComponent(
                                images: 'assets/images/building.png',
                                title: 'อาคาร/สถานที่',
                                isDisabledButton: true,
                              )
                            : SosComponent(
                                images: 'assets/images/building.png',
                                title: 'อาคาร/สถานที่',
                              ),
                        onPressed: () {
                          print('อาคาร/สถานที่');
                          setState(() {
                            if (onSelect == 3) {
                              onSelect = 0;
                            } else {
                              onSelect = 3;
                            }
                          });
                        },
                      ),
                      TextButton(
                        autofocus: false,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: onSelect == 4 || onSelect == 0
                            ? SosComponent(
                                images: 'assets/images/others.png',
                                title: 'อื่นๆ',
                                isDisabledButton: true,
                              )
                            : SosComponent(
                                images: 'assets/images/others.png',
                                title: 'อื่นๆ',
                              ),
                        onPressed: () {
                          print('อื่นๆ');
                          setState(() {
                            if (onSelect == 4) {
                              onSelect = 0;
                            } else {
                              onSelect = 4;
                            }
                          });
                        },
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
                      borderRadius: BorderRadius.circular(20), //<-- SEE HERE
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SosPage1(),
                            ),
                          );
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

class SosPage1 extends StatefulWidget {
  const SosPage1({super.key});

  @override
  State<SosPage1> createState() => _SosPage1State();
}

class _SosPage1State extends State<SosPage1> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final int _pageNumber = 2;

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = '';

  String images = '';
  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagepath = pickedFile.path;
        File imagefile = File(imagepath);
        Uint8List imagebytes = await imagefile.readAsBytes();
        String base64string = base64.encode(imagebytes);

        Uint8List decodedbytes = base64.decode(base64string);

        String tobase64 = base64Encode(decodedbytes);
        setState(() {
          images = tobase64;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

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
        automaticallyImplyLeading: true,
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
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(0),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: const Text(
                              'ประเภทของการแจ้งเหต :  ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            child: const SelectableText(
                              'อาคาร/สถานที่',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            alignment: Alignment.center,
                            child: const Text(
                              'รายละเอียด :  ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            child: const SelectableText(
                              'มีไฟไหม้ที่ ห้างสรรพสินค้า',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 35, 10, 5),
                  child: const Text(
                    'เบอร์โทรศัพท์สำหรับติดต่อกลับ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      borderRadius: BorderRadius.circular(3), //<-- SEE HERE
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        onChanged: (value) => setState(() {
                          // _textArea = value;
                          print("1");
                        }),
                        maxLines: 3,
                        maxLength: null, //or null
                        decoration: const InputDecoration.collapsed(
                          hintText: "",
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () => {openImage()},
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 50.0,
                          ),
                        ),
                        images == ''
                            ? const Text(
                                'กรุณา แนบรูปภาพ ***',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.transparent, // Step 2 SEE HERE
                                  shadows: [
                                    Shadow(
                                        offset: Offset(0, -5),
                                        color: Colors.black)
                                  ],
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 177, 0, 0),
                                ),
                              )
                            : const Text(
                                'แนบรูปภาพ สำเร็จ',
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.transparent, // Step 2 SEE HERE
                                  shadows: [
                                    Shadow(
                                        offset: Offset(0, -5),
                                        color: Colors.black)
                                  ],
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 34, 172, 0),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: SizedBox(
                      width: 330.48,
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
                          "แจ้งเหตุ",
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
