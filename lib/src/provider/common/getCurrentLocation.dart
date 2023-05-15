import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      SystemNavigator.pop();
      exit(0);
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    SystemNavigator.pop();
    exit(0);
    return Future.error(
        'Location Permissions are permanently denied, we cannot request Permissions');
  }


  return await Geolocator.getCurrentPosition();
}

liveLocation() {
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
  });
}
