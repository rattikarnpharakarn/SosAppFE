import 'package:shared_preferences/shared_preferences.dart';

getUserIDSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('id');
  return id;
}

getUserPhoneNumberSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final phoneNumber = prefs.getString('phoneNumber');

  return phoneNumber;
}

getUserFirstNameSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final firstName = prefs.getString('firstName');
  return firstName;
}

getUserLastNameSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final lastName = prefs.getString('lastName');
  return lastName;
}

getUserEmailSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  return email;
}

getUserBirthdaySF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final birthday = prefs.getString('birthday');
  return birthday;
}

getUserGenderSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final gender = prefs.getString('gender');
  return gender;
}

getUserImageProfileSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final imageProfile = prefs.getString('imageProfile');
  return imageProfile;
}

getUserTextIDCardSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  final textIDCard = prefs.getString('textIDCard');
  return textIDCard;
}

getUserPathImageSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final pathImage = prefs.getString('pathImage');
  return pathImage;
}

getUserAddressSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final address = prefs.getString('address');
  return address;
}

getUserSubDistrictSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final subDistrict = prefs.getString('subDistrict');
  return subDistrict;
}

getUserDistrictSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final district = prefs.getString('district');
  return district;
}

getUserProvinceSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final province = prefs.getString('province');
  return province;
}

getUserPostalCodeSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final postalCode = prefs.getString('postalCode');
  return postalCode;
}

getUserCountrySF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final country = prefs.getString('country');
  return country;
}

getUserTokenSf() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final stringValue = prefs.getString('token');
  return stringValue;
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('id');
  prefs.remove('token');
  prefs.remove('phoneNumber');
  prefs.remove('firstName');
  prefs.remove('lastName');
  prefs.remove('email');
  prefs.remove('birthday');
  prefs.remove('gender');
  prefs.remove('imageProfile');
  prefs.remove('textIDCard');
  prefs.remove('pathImage');
  prefs.remove('address');
  prefs.remove('subDistrict');
  prefs.remove('district');
  prefs.remove('province');
  prefs.remove('postalCode');
  prefs.remove('country');
}
