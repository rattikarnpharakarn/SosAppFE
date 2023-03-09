import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/provider/userService.dart';

getUserIDSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('id') ?? '';
  return id;
}

getUserPhoneNumberSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String phoneNumber = prefs.getString('phoneNumber') ?? '';
  return phoneNumber;
}

getUserFirstNameSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String firstName = prefs.getString('firstName') ?? '';
  return firstName;
}

getUserLastNameSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String lastName = prefs.getString('lastName') ?? '';
  return lastName;
}

getUserEmailSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email') ?? '';
  return email;
}

getUserBirthdaySF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String birthday = prefs.getString('birthday') ?? '';
  return birthday;
}

getUserGenderSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String gender = prefs.getString('gender') ?? '';
  return gender;
}

getUserImageProfileSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String imageProfile = prefs.getString('imageProfile') ?? '';
  return imageProfile;
}

getUserTextIDCardSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  String textIDCard = prefs.getString('textIDCard') ?? '';
  return textIDCard;
}

getUserPathImageSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String pathImage = prefs.getString('pathImage') ?? '';
  return pathImage;
}

getUserAddressSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String address = prefs.getString('address') ?? '';
  return address;
}

getUserSubDistrictSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String subDistrict = prefs.getString('subDistrict') ?? '';
  return subDistrict;
}

getUserDistrictSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String district = prefs.getString('district') ?? '';
  return district;
}

getUserProvinceSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String province = prefs.getString('province') ?? '';
  return province;
}

getUserPostalCodeSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String postalCode = prefs.getString('postalCode') ?? '';
  return postalCode;
}

getUserCountrySF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String country = prefs.getString('country') ?? '';
  return country;
}

getUserTokenSf() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('token') ?? '';
  return stringValue;
}

addUserProfileToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = await GetUserProfile();
  prefs.setString('id', data.id);
  prefs.setString('phoneNumber', data.phoneNumber);
  prefs.setString('firstName', data.firstName);
  prefs.setString('lastName', data.lastName);
  prefs.setString('email', data.email);
  prefs.setString('birthday', data.birthday);
  prefs.setString('gender', data.gender);
  prefs.setString('imageProfile', data.imageProfile);

  prefs.setString('textIDCard', data.textIDCard);
  prefs.setString('pathImage', data.pathImage);

  prefs.setString('address', data.address);
  prefs.setString('subDistrict', data.subDistrict);
  prefs.setString('district', data.district);
  prefs.setString('province', data.province);
  prefs.setString('postalCode', data.postalCode);
  prefs.setString('country', data.country);
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
