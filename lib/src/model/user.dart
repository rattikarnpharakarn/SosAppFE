class UserInfo {
  String id = '';
  String phoneNumber = '';
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

  UserInfo({
    required this.id,
    required this.phoneNumber,
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
  });

  Map toJson() {
    return {
      'id' : id,
      'phoneNumber': phoneNumber,
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
      }
    };
  }
}