import 'dart:math' as math;

import 'package:sos/src/provider/common/getCurrentLocation.dart';
import 'package:sos/src/provider/common/model.dart';

Future<double> getDistanceBetweenPoints(
    double latitude1,double longitude1,double latitude2,double longitude2,String unit) async {

  double theta = longitude1 - longitude2;
  double distance = 60 *
      1.1515 *
      (180 / math.pi) *
      math.acos(math.sin(latitude1 * (math.pi / 180)) *
              math.sin(latitude2 * (math.pi / 180)) +
          math.cos(latitude1 * (math.pi / 180)) *
              math.cos(latitude2 * (math.pi / 180)) *
              math.cos(theta * (math.pi / 180)));

  double res = distance;
  if (unit == 'miles') {
    return distance;
  } else if (unit == 'kilometers') {
    res = distance * 1.609344;
    return res;
  }
  return res;
}


Future<bool> checkDistanceBetweenPoints(double currentLatitude,double currentLongitude, String lat , String long) async{
  bool res = false;

  // todo Destination Location
   double latitude = double.parse(lat);
   double longitude = double.parse(long);

  double unit = await getDistanceBetweenPoints(
      latitude, longitude, currentLatitude, currentLongitude, "kilometers");
  unit += 2;

  if (unit <= 9){
    res = true;
  }
  return res;
}