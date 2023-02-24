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
  // IDCard
  String textIDCard = '';
  String pathImage = '';
  // address
  String address = '';
  String subDistrict = '';
  String district = '';
  String province = '';
  String postalCode = '';
  String country = '';
  //Verify
  String otp = '';
  String verifyCode = '';

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
    // IDCard
    required this.textIDCard,
    required this.pathImage,
    // address
    required this.address,
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.postalCode,
    required this.country,
    //Verify
    required this.otp,
    required this.verifyCode,
  });

  Map toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthday': birthday,
      'gender': gender,
      'imageProfile': imageProfile,
      'idCard': {
        'textIDCard': textIDCard,
        'pathImage': pathImage,
      },
      'address': {
        'address': address,
        'subDistrict': subDistrict,
        'district': district,
        'province': province,
        'postalCode': postalCode,
        'country': "ไทย"
      },
      'verify': {
        'otp': otp,
        'verifyCode': verifyCode,
      }
    };
  }
}

class IdCard {
  String textIDCard = '';
  String pathImage = '';

  IdCard({
    required this.textIDCard,
    required this.pathImage,
  });

  Map toJson() {
    return {
      'textIDCard': textIDCard,
      'pathImage': pathImage,
    };
  }
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

  Map toJson() {
    return {
      'address': address,
      'subDistrict': subDistrict,
      'district': district,
      'province': province,
      'postalCode': postalCode,
      'country': "ไทย"
    };
  }
}

class Verify {
  String otp = '';
  String verifyCode = '';

  Verify({
    required this.otp,
    required this.verifyCode,
  });

  Map toJson() {
    return {
      'otp': otp,
      'verifyCode': verifyCode,
    };
  }
}
