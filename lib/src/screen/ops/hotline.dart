import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sos/src/provider/config.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../component/bottom_bar.dart';
import '../../component/button_bar_ops.dart';
import '../../component/endDrawer.dart';
import '../../component/image_navBer.dart';
import '../../model/accounts/user.dart';
import '../../model/hotlines/response.dart';
import '../../provider/accounts/userService.dart';
import '../../provider/hotlines/hotlineService.dart';
import '../common/LoadingPage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HotlinePage extends StatefulWidget {



  const HotlinePage({super.key});

  @override
  State<HotlinePage> createState() => HotlinePageState();
}


class HotlinePageState extends State<HotlinePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<GetHotline> getHotlineList = [];
  bool isLoading = false;

  late UserInfo userProfile;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
    callAPIHotline();
  }

  _getUserProfile() async {
    UserInfo data = await GetUserProfile();
    setState(() {
      userProfile = data;
    });
  }


  callAPIHotline() async {
    await GetHotlineList().then((value) {
      setState(() {
        for (var data in value.list) {
          GetHotline getHotline = GetHotline(
              id: data.id, number: data.number, description: data.description);
          getHotlineList.add(getHotline);
        }
      });
    });

    setState(() {
      isLoading = true;
    });
  }

  _logHotline(int  hotlineId ,int  userid) async {
   await postHotline(hotlineId , userid);
  }

  int _pageNumber = 1;

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          key: _key,
          bottomNavigationBar: ButtonBarOps(
            pageNumber: _pageNumber,
          ),
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
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: const Text(
                          "Hotline",
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
          endDrawer: EndDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: const Text(
                    'เบอร์โทรสายด่วน',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
                for (GetHotline m1 in getHotlineList) ...[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(m1.description,
                                      style: const TextStyle(fontSize: 22.0)),
                                ),
                                const Spacer(),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(m1.number,
                                      style: const TextStyle(
                                          fontSize: 23.0, color: Colors.red)),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 18.0,
                                    width: 18.0,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      icon: const Icon(Icons.phone,
                                          size: 22.0, color: Colors.black),
                                      onPressed: () async {
                                        _logHotline(m1.id,int.parse(userProfile.id));
                                        String telephoneNumber = m1.number;
                                        String telephoneUrl =
                                            "tel:$telephoneNumber";
                                        await launchUrlString(telephoneUrl);
                                        // todo เหลือเก็บ log ในการโทร
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
}
