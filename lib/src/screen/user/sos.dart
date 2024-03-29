import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sos/src/component/bottom_bar.dart';
import 'package:sos/src/component/endDrawer.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/component/sosComponent.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/common/socketConnectNotification.dart';
import 'package:sos/src/provider/emergency/inform.dart';
import 'package:sos/src/screen/common/detailImage.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../common/LoadingPage.dart';
import 'history.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sos/src/provider/emergency/type.dart' as provider;

class SosPage extends StatefulWidget {
  const SosPage({super.key, required this.typeId});

  final String typeId;

  @override
  State<SosPage> createState() => SosPageState();
}

class SosPageState extends State<SosPage> {
  final GlobalKey<ScaffoldState> _formKey = GlobalKey();

  final int _pageNumber = 2;
  String _textArea = '';
  String _onSelectName = '';

  late int onSelect = 0;
  late List<bool> _isChecked;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getSubType();
    // Future.delayed(Duration(milliseconds: 500), () {
    //   setState(() {
    //     isLoading = true;
    //   });
    // });
  }

  List<GetSubType> getSubTypeList = [];

  _getSubType() async {
    String typeId = widget.typeId;
    if (typeId == "0") {
      await _getAllSubType();
    } else {
      await _getSubTypeByTypeId();
    }
    setState(() {
      isLoading = true;
    });
  }

  _getAllSubType() async {
    await provider.getSubType().then((value) {
      if (value.code == "0") {
        setState(() {
          for (var data in value.data) {
            GetSubType getSubType = GetSubType(
              id: data.id,
              createdAt: data.createdAt,
              updatedAt: data.updatedAt,
              nameSubType: data.nameSubType,
              imageSubType: data.imageSubType,
              deletedBy: data.deletedBy,
            );
            getSubTypeList.add(getSubType);
          }
        });
      }
      _isChecked = List<bool>.filled(getSubTypeList.length + 1, true);
    });
  }

  _getSubTypeByTypeId() async {
    await provider.getTypeById(widget.typeId).then((value) {
      if (value.code == "0") {
        setState(() {
          for (var data in value.data.getSubType!) {
            GetSubType getType = GetSubType(
              id: data.id,
              createdAt: data.createdAt,
              updatedAt: data.updatedAt,
              nameSubType: data.nameSubType,
              imageSubType: data.imageSubType,
              deletedBy: data.deletedBy,
            );
            getSubTypeList.add(getType);
          }
        });
      }
      _isChecked = List<bool>.filled(getSubTypeList.length + 1, false);
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
                      child: GridView.builder(
                        primary: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: getSubTypeList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return TextButton(
                            autofocus: false,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: const CircleBorder(),
                            ),
                            child: SosComponent(
                              images: getSubTypeList[index].imageSubType,
                              title: getSubTypeList[index].nameSubType,
                              isDisabledButton: _isChecked[index],
                            ),
                            onPressed: () {
                              setState(() {
                                if (onSelect ==
                                    int.parse(getSubTypeList[index].id)) {
                                  _isChecked = List<bool>.filled(
                                      getSubTypeList.length + 1, false);
                                  onSelect = 0;
                                } else {
                                  _onSelectName =
                                      getSubTypeList[index].nameSubType;
                                  _isChecked = List<bool>.filled(
                                      getSubTypeList.length + 1, false);
                                  _isChecked[index] = true;
                                  onSelect =
                                      int.parse(getSubTypeList[index].id);
                                }
                              });
                            },
                          );
                        },
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
                              if (onSelect == 0 || _textArea == '') {
                                String msg = '';
                                if (onSelect == 0) {
                                  msg = 'กรุณาเลือกประเภทของการแจ้งเหตุ';
                                } else if (_textArea == '') {
                                  msg = 'กรุณาเพิ่มคำอธิบาย';
                                }
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
                                                  child: Text(
                                                    msg,
                                                    style: const TextStyle(
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

  @override
  void dispose() {
    super.dispose();
  }
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
  final TextEditingController _textPhoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String latitude = '';
  String longitude = '';
  int userID = 0;

  late IO.Socket _socket;
  bool isLoading = false;

  final int _pageNumber = 2;
  String selected_location = '';
  String location_on = '';

  final ImagePicker imgpicker = ImagePicker();
  String selected_camera_or_image = '';

  String imagepath = '';
  List<String> imagepages = [];

  late String lat;
  late String long;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      _connectSocket();
      setState(() {
        isLoading = true;
      });
    });
  }

  _connectSocket() async {
    UserInfo data = await GetUserProfile();
    _socket = await connectSocket(data);
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }

  openImage(String imageSource) async {
    try {
      var pickedFile;
      if (imageSource == "gallery") {
        // pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
        List<XFile>? pickedfiles = await imgpicker.pickMultiImage();
        if (pickedfiles != null) {
          pickedfiles.map((imageone) async {
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

  Future<void> _callAPIInform() async {
    UserInfo data = await GetUserProfile();

    Inform req = Inform(
      description: widget.textArea,
      images: imagepages,
      latitude: latitude,
      longitude: longitude,
      phoneNumberCallBack: _textPhoneNumber.text.trim(),
      subTypeID: widget.onSelectSubTypeId,
      userID: data.id,
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
      _socket.emit("0", {
        "description": widget.textArea,
        "phoneNumberCallBack": _textPhoneNumber.text.trim(),
        "latitude": latitude,
        "longitude": longitude,
        "type": widget.onSelectName,
      });

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
                          'คุณได้ทำการแจ้งเหตุเรียบร้อยแล้ว',
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
                              onPressed: () => {
                                _socket.ondisconnect(),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HistoryPage(),
                                  ),
                                ),
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
      // _showNotification();
    }
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
                key: formKey,
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
                            style: const TextStyle(fontSize: 16),
                            keyboardType: TextInputType.phone,
                            controller: _textPhoneNumber,
                            maxLines: 1,
                            maxLength: 10,
                            decoration:
                                const InputDecoration.collapsed(hintText: ""),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
                      child: location_on != '' && imagepages != ''
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
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                // PopupMenuItem<String>(
                                //   value: 'newAddress',
                                //   child: Text('เลือกที่อยู่'),
                                //   onTap: () {
                                //     print('เลือกที่อยู่');
                                //   },
                                // ),
                                PopupMenuItem<String>(
                                  value: 'currentAddress',
                                  child: const Text('ที่อยู่ปัจจุบัน'),
                                  onTap: () {
                                    _getCurrentLocation().then((value) async {
                                      lat = '${value.latitude}';
                                      long = '${value.longitude}';

                                      _liveLocation();
                                      setState(() {
                                        latitude = lat;
                                        longitude = long;
                                      });
                                      // await _openMap(lat, long);
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
                                color: imagepages.length <= 0
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
                      child: imagepages == []
                          ? null
                          : Wrap(
                              children: imagepages.map(
                                (imageone) {
                                  return Container(
                                    padding: const EdgeInsets.all(1.0),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(images: imageone),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            base64Decode(imageone),
                                            width: 55,
                                            height: 55,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
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
                              "แจ้งเหตุ",
                              style: TextStyle(fontSize: 24),
                            ),
                            onPressed: () {
                              // todo กรุณากรอกเบอร์โทรให้ถูกต้อง
                              if (_textPhoneNumber.text.trim().length != 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarSos(
                                      context,
                                      const Text(
                                        'กรุณากรอกเบอร์โทรให้ถูกต้อง',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                      ),
                                      Colors.white),
                                );
                              } else if (location_on == '') {
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
                                                    'กรุณาเลือกที่อยู่',
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
                                                    'คุณต้องการที่แจ้งเหตุ ใช่หรือไม่',
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
                                                          'ยกเลิกการแจ้งเหตุ',
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
                                                          'ยืนยันการแจ้งเหตุ',
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
