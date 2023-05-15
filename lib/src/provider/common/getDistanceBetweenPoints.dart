import 'dart:math' as math;

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
