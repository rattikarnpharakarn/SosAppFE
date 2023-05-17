import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/emergency/type.dart' as provider;
import 'package:sos/src/screen/user/sos.dart';

import '../../component/bottom_bar.dart';
import '../../component/endDrawer.dart';
import '../../component/image_navBer.dart';
import '../../sharedInfo/user.dart';
import '../common/LoadingPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController controller = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 500), () {
    // });
    _getGetType();
    _getNameProfile();
  }

  final int _pageNumber = 0;

  String _name = '';

  _getNameProfile() async {
    var name = await getUserFirstNameSF();
    setState(() {
      _name = name;
    });
  }

  List<GetType> getTypeList = [];

  _getGetType() async {
    await provider.getType().then((value) {
      if (value.code == "0") {
        setState(() {
          for (var data in value.data) {
            GetType getType = GetType(
              id: data.id,
              createdAt: data.createdAt,
              updatedAt: data.updatedAt,
              nameType: data.nameType,
              imageType: data.imageType,
              deletedBy: data.deletedBy,
              getSubType: [],
            );
            getTypeList.add(getType);
          }
        });
      }
    });
    setState(() {
      isLoading = true;
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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          "Hi ${_name}",
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  width: 500,
                  height: 250,
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/home.jpeg"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        // leading: Icon(Icons.album, size: 60),
                        title: Text('ข่าวสาร',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white70)),
                        subtitle: Text('เกิดเหตุการณ์ไฟไหม้ที่....',
                            style:
                                TextStyle(fontSize: 27.0, color: Colors.white)),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 230, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'คลิกเพื่ออ่านต่อ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: const Text(
                    'แจ้งเหตุ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
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
                      for (GetType getType in getTypeList) ...[
                        Card(
                          color: const Color.fromRGBO(210, 250, 251, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SosPage(typeId: getType.id),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  child: getType.imageType != ""
                                      ? Image.memory(
                                          base64Decode(getType.imageType),
                                          height: 100,
                                        )
                                      : const Text(""),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    getType.nameType,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(12, 75, 142, 1),
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}
