import 'package:flutter/cupertino.dart';
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
  final GlobalKey<ScaffoldState> _formKey = GlobalKey();

  final int _pageNumber = 2;
  String _textArea = '';
  String _onSelectName = '';

  int onSelect = 0;

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
          key: _formKey,
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
                      "????????????????????????",
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
                        _formKey.currentState!.openEndDrawer();
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
                                    title: '????????????????????????',
                                    isDisabledButton: true,
                                  )
                                : SosComponent(
                                    images: 'assets/images/sick.png',
                                    title: '????????????????????????',
                                  ),
                            onPressed: () {
                              setState(() {
                                if (onSelect == 1) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = '????????????????????????';
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
                                    title: '??????????????????????????????',
                                    isDisabledButton: true,
                                  )
                                : SosComponent(
                                    images: 'assets/images/accident.png',
                                    title: '??????????????????????????????',
                                  ),
                            onPressed: () {
                              setState(() {
                                if (onSelect == 2) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = '??????????????????????????????';
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
                                    title: '???????????????/?????????????????????',
                                    isDisabledButton: true,
                                  )
                                : SosComponent(
                                    images: 'assets/images/building.png',
                                    title: '???????????????/?????????????????????',
                                  ),
                            onPressed: () {
                              setState(() {
                                if (onSelect == 3) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = '???????????????/?????????????????????';
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
                                    title: '???????????????',
                                    isDisabledButton: true,
                                  )
                                : SosComponent(
                                    images: 'assets/images/others.png',
                                    title: '???????????????',
                                  ),
                            onPressed: () {
                              setState(() {
                                if (onSelect == 4) {
                                  onSelect = 0;
                                } else {
                                  _onSelectName = '???????????????';
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
                              hintText: "???????????????????????????????????????????????????",
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
                              if (onSelect == 0 || _textArea == '') {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(1),
                                      child: Center(
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Text(
                                                    '?????????????????????????????????????????????????????????????????????????????????????????? ???????????? '
                                                    '???????????????????????????????????????',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      decoration:
                                                          TextDecoration.none,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .double,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      child: ElevatedButton(
                                                        style: const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors
                                                                        .red)),
                                                        child: const Text(
                                                          'ok',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
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
                              }
                            },
                            child: const Text(
                              "???????????????",
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
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isLoading = false;

  String _textPhoneNumber = '';
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

  final int _pageNumber = 2;
  String selected_location = '';
  String location_on = '';

  final ImagePicker imgpicker = ImagePicker();
  String selected_camera_or_image = '';

  String imagepath = '';
  List<String> imagepages = [];

  openImage(String imageSource) async {
    try {
      var pickedFile;
      if (imageSource == "gallery") {
        // pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
        List<XFile>? pickedfiles = await imgpicker.pickMultiImage();
        if (pickedfiles != null) {
          pickedfiles!.map((imageone) async {
            String imagepath1 = '';
            imagepath1 = imageone.path;
            File imagefile = File(imagepath1);
            Uint8List imagebytes = await imagefile.readAsBytes();
            String base64string = base64.encode(imagebytes);

            Uint8List decodedbytes = base64.decode(base64string);

            String tobase64 = base64Encode(decodedbytes);

            setState(() {
              imagepages.add(tobase64);
            });
          }).toList();
        } else {
          print("No image is selected.");
        }
      } else if (imageSource == "camera") {
        pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          imagepath = pickedFile.path;
          File imagefile = File(imagepath);
          Uint8List imagebytes = await imagefile.readAsBytes();
          String base64string = base64.encode(imagebytes);

          Uint8List decodedbytes = base64.decode(base64string);

          String tobase64 = base64Encode(decodedbytes);
          setState(() {
            imagepages.add(tobase64);
          });
        } else {
          print("No image is selected.");
        }
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
      images: imagepages,
      latitude: latitude,
      longitude: longitude,
      phoneNumberCallBack: _textPhoneNumber,
      subTypeID: widget.onSelectSubTypeId,
      userID: id,
    );

    var res = await PostInform(req);
    if (res.code != '0') {
      // ignore: use_build_context_synchronously
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(1),
            child: Center(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Error : ${res.message}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            decorationStyle: TextDecorationStyle.double,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.red)),
                              child: const Text(
                                'ok',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(1),
            child: Center(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child: const Text(
                          '????????????????????????????????????????????????????????????????????????????????????????????????',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            decorationStyle: TextDecorationStyle.double,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.red)),
                              child: const Text(
                                'ok',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HistoryPage(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
      // _showNotification();
    }
  }

  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'nextflow_noti_002',
  //     '???????????????????????????',
  //     channelDescription: 'Sos',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //
  //   const NotificationDetails platformChannelDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //
  //   await ShowflutterLocalNoificationPlugin.show(1, '???????????????????????????????????????????????????',
  //       '????????????????????????????????????????????????????????????????????????????????????????????????', platformChannelDetails);
  // }

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
                      "????????????????????????",
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
                            '????????????????????????????????????????????????????????? :  ',
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
                      '??????????????????????????????',
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
                        '???????????????????????????????????????????????????????????????????????????????????????',
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
                      child: location_on != '' && imagepages != ''
                          ? const Text(
                              '????????????????????????????????????????????????????????????????????????????????????????????????',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green),
                            )
                          : const Text(
                              '** ??????????????????????????????????????????????????? ????????? ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
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
                            // todo ????????????????????????????????????????????????????????????????????? Location ???????????????????????????????????????????????????
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
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'newAddress',
                                  child: Text('????????????????????????????????????'),
                                  onTap: () {
                                    print('????????????????????????????????????');
                                  },
                                ),
                                PopupMenuItem<String>(
                                  value: 'currentAddress',
                                  child: const Text('?????????????????????????????????????????????'),
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
                                color: imagepages == ''
                                    ? Colors.red
                                    : Colors.green,
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
                                  child: Text('???????????????????????????'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'gallery',
                                  child: Text('???????????????????????????'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: imagepages == null
                          ? null
                          : Wrap(
                              children: imagepages.map((imageone) {
                                return TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(images: imageone),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      child: Card(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.memory(
                                          base64Decode(imageone),
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )),
                                );
                              }).toList(),
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
                            child: const Text(
                              "????????????????????????",
                              style: TextStyle(fontSize: 24),
                            ),
                            onPressed: () {
                              if (location_on == '') {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(1),
                                      child: Center(
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Text(
                                                    '???????????????????????????????????????????????????',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      decoration:
                                                          TextDecoration.none,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .double,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      child: ElevatedButton(
                                                        style: const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors
                                                                        .red)),
                                                        child: const Text(
                                                          'ok',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(1),
                                      child: Center(
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: const Text(
                                                    '??????????????????????????????????????????????????????????????? ??????????????????????????????',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      decoration:
                                                          TextDecoration.none,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .double,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      child: ElevatedButton(
                                                        style: const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors
                                                                        .red)),
                                                        child: const Text(
                                                          '???????????????????????????????????????????????????',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      child: ElevatedButton(
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Colors.green),
                                                        ),
                                                        child: const Text(
                                                          '???????????????????????????????????????????????????',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        onPressed: () {
                                                          _callAPIInform();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
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

class DetailScreen extends StatefulWidget {
  String images;

  DetailScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.memory(
              base64Decode(widget.images),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
