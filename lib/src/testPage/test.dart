import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sos/src/component/bottom_bar.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../component/endDrawer.dart';
import '../component/image_navBer.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final int _pageNumber = 2;
  String locationMessage = 'Current Location of the User';

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

    setState(() {
      locationMessage = 'Latitude : $lat , Longitude : $long';
    });
  }

  Future<void> _openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';


    await launchUrlString(googleURL);
    // if (await canLaunchUrlString(googleURL)) {
    //   await launchUrlString(googleURL);
    // } else {
    //   throw 'Could not launch $googleURL';
    // }
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
                  "ทดสอบ",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _getCurrentLocation().then((value) {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    setState(() {
                      locationMessage = 'Latitude : $lat , Longitude : $long';
                    });
                    _liveLocation();
                  });
                },
                child: Text("Get Current Location"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _openMap(lat, long);
                },
                child: Text("Open Google Map"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
