import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/main.dart';

import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/component/sosComponent.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/provider/emergency/inform.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:sos/src/screen/LoadingPage.dart';
import 'package:sos/src/screen/history.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/emergency/response.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => NSosPageState();
}

class NSosPageState extends State<SosPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final int _pageNumber = 2;
  String _textArea = '';
  String _onSelectName = '';

  int onSelect = 0;

  // int indexOnSelect = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
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
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Image_NavBer(height: 40, width: 40),
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.zero,
                      height: 380,
                      width: 400,
                      child: GridView.count(
                        primary: true,
                        padding: const EdgeInsets.all(20),
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
                              setState(() {
                                if (onSelect == 1) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = 'เจ็บป่วย';
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
                              setState(() {
                                if (onSelect == 2) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = 'อุบัติเหตุ';
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
                              setState(() {
                                if (onSelect == 3) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = 'อาคาร/สถานที่';
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
                              setState(() {
                                if (onSelect == 4) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = 'อื่นๆ';
                                  onSelect = 4;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 51, 51, 51),
                          ),
                          borderRadius:
                              BorderRadius.circular(20), //<-- SEE HERE
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            onChanged: (value) => setState(() {
                              _textArea = value;
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
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                                  builder: (context) => SosPage1(
                                    onSelectSubTypeId: onSelect,
                                    onSelectName: _onSelectName,
                                    textArea: _textArea,
                                  ),
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

class SosPage1 extends StatefulWidget {
  int onSelectSubTypeId;
  String textArea;
  String onSelectName;

  SosPage1({
    super.key,
    required this.onSelectSubTypeId,
    required this.textArea,
    required this.onSelectName,
  });

  @override
  State<SosPage1> createState() => _SosPage1State();
}

class _SosPage1State extends State<SosPage1> {
  bool isLoading = false;

  String _textPhoneNumber = '';
  String images = '';
  String latitude = '';
  String longitude = '';
  int userID = 0;

  // _description = widget.textArea;
  // _subTypeId = widget.onSelectSubTypeId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = true;
      });
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final int _pageNumber = 2;
  String selected_location = '';
  String location_on = '';

  final ImagePicker imgpicker = ImagePicker();

  String selected_camera_or_image = '';

  String imagepath = '';

  openImage(String imageSource) async {
    try {
      var pickedFile;

      if (imageSource == "gallery") {
        pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      } else if (imageSource == "camera") {
        pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      } else {}

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

  late String lat;
  late String long;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permissions are permanently denied, we cannot request Permissions');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  Future<void> _openMap(String lat, String long) async {
    setState(() {
      latitude = lat;
      longitude = long;
    });
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';

    await launchUrlString(googleURL);
    // if (await canLaunchUrlString(googleURL)) {
    //   await launchUrlString(googleURL);
    // } else {
    //   throw 'Could not launch $googleURL';
    // }
  }

  Future<void> _callAPIInform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? '';
    Inform req = Inform(
      description: widget.textArea,
      images: images,
      latitude: latitude,
      longitude: longitude,
      phoneNumberCallBack: _textPhoneNumber,
      subTypeID: widget.onSelectSubTypeId,
      userID: id,
    );

    await PostInform(req);
    _showNotification();

    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        ),
      );
    });
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'nextflow_noti_002',
      'แจ้งเตือน',
      channelDescription: 'Sos',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await ShowflutterLocalNoificationPlugin.show(1, 'ยืนยันการแจ้งเหตุ',
        'คุณได้ทำการแจ้งเหตุเรียบร้อยแล้ว', platformChannelDetails);
  }

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
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
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Image_NavBer(height: 40, width: 40),
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
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: [
                    Row(
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
                          child: Text(
                            widget.onSelectName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    ),
                    const Text(
                      'รายละเอียด',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    ),
                    SizedBox(
                      child: Text(
                        widget.textArea,
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
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
                              _textPhoneNumber = value;
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
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
                      child: location_on != '' && images != ''
                          ? const Text(
                              'เพิ่มรูปภาพและเลือกที่อยู่สำเร็จ',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green),
                            )
                          : const Text(
                              '** กรุณาเลือกที่อยู่ และ เพิ่มรูปภาพเพื่อทำให้ข้อมูลครบถ้วนในการแจ้งเหตุ',
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // todo ยังไม่ได้เพิ่มในส่วนของ Location ให้สามารถเลือกได้
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: PopupMenuButton<String>(
                              initialValue: selected_location,
                              child: Icon(
                                color: location_on == ''
                                    ? Colors.red
                                    : Colors.green,
                                Icons.location_on,
                                size: 40.0,
                              ),
                              // Callback that sets the selected popup menu item.
                              onSelected: (String item) {
                                setState(() {
                                  location_on = item;
                                  print(location_on);
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'newAddress',
                                  child: Text('เลือกที่อยู่'),
                                  onTap: () {
                                    print('เลือกที่อยู่');
                                  },
                                ),
                                PopupMenuItem<String>(
                                  value: 'currentAddress',
                                  child: const Text('ที่อยู่ปัจจุบัน'),
                                  onTap: () {
                                    _getCurrentLocation().then((value) async {
                                      lat = '${value.latitude}';
                                      long = '${value.longitude}';
                                      _liveLocation();
                                      await _openMap(lat, long);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: PopupMenuButton<String>(
                              initialValue: selected_camera_or_image,
                              child: Icon(
                                color: images == '' ? Colors.red : Colors.green,
                                Icons.camera_alt,
                                size: 40.0,
                              ),
                              // Callback that sets the selected popup menu item.
                              onSelected: (String item) {
                                setState(() {
                                  selected_camera_or_image = item;
                                  openImage(selected_camera_or_image);
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'camera',
                                  child: Text('เปิดกล้อง'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'gallery',
                                  child: Text('เลือกไฟล์'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
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
                              _callAPIInform();
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
