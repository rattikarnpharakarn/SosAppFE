class UserInfo {
  String phoneNumber = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String email;
  String birthday = '';
  String gender = '';
  String imageProfile = '';
  IdCard idCard;
  Address address;
  Verify verify;

  UserInfo({
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.imageProfile,
    required this.idCard,
    required this.address,
    required this.verify,
  });
}

class IdCard {
  String textIDCard = '';
  String pathImage = '';

  IdCard({
    required this.textIDCard,
    required this.pathImage,
  });
}

class Address {
  String address = '';
  String subDistrict = '';
  String district = '';
  String province = '';
  String postalCode = '';
  String country = '';

  Address({
    required this.address,
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.postalCode,
    required this.country,
  });
}

class Verify {
  String otp = '';
  String verifyCode = '';

  Verify({
    required this.otp,
    required this.verifyCode,
  });
}
