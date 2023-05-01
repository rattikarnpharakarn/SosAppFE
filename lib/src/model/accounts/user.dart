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
      'id': id,
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

class UserImage {
  String id = '';
  String imageProfile = '';

  UserImage({
    required this.id,
    required this.imageProfile,
  });

  Map toJson() {
    return {
      'id': id,
      'imageProfile': imageProfile,
    };
  }
}

class GetUserListModel {
  final String message;
  final String code;
  final int total;
  final List<GetUserList> list;

  GetUserListModel({
    required this.code,
    required this.message,
    required this.total,
    required this.list,
  });

  factory GetUserListModel.fromJson(Map<String, dynamic> json) {
    List<GetUserList>? list = [];
    for (dynamic json in json['data']) {
      GetUserList arr = GetUserList(
        id: json['id'],
        phoneNumber: json['phoneNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        birthday: json['birthday'],
        gender: json['gender'],
        imageProfile: json['imageProfile'],
        // workplace: json['workplace'],
        // IDCard
        textIDCard: json['idCard']['textIDCard'],
        pathImage: json['idCard']['pathImage'],
        // address
        address: json['address']['address'],
        subDistrict: json['address']['subDistrict'],
        district: json['address']['district'],
        province: json['address']['province'],
        postalCode: json['address']['postalCode'],
        country: json['address']['country'],
      );
      list.add(arr);
    }

    return GetUserListModel(
      code: json['code'],
      message: json['message'],
      total: json['total'],
      list: list,
    );
  }
}

class GetUserList {
  String id = '';
  String phoneNumber = '';
  String firstName = '';
  String lastName = '';
  String email;
  String birthday = '';
  String gender = '';
  String imageProfile = '';
  // String workplace = '';

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

  GetUserList({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.imageProfile,
    // required this.workplace,
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

  factory GetUserList.fromJson(Map<String, dynamic> json) {
    return GetUserList(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      birthday: json['birthday'],
      gender: json['gender'],
      imageProfile: json['imageProfile'],
      // workplace: json['workplace'],
      // IDCard
      textIDCard: json['idCard']['textIDCard'],
      pathImage: json['idCard']['pathImage'],
      // address
      address: json['address']['address'],
      subDistrict: json['address']['subDistrict'],
      district: json['address']['district'],
      province: json['address']['province'],
      postalCode: json['address']['postalCode'],
      country: json['address']['country'],
    );
  }
}
