class ReturnResponse {
  String message = '';
  String code = '';

  // ignore: prefer_typing_uninitialized_variables
  final data;

  ReturnResponse({
    required this.message,
    required this.code,
    this.data,
  });

  factory ReturnResponse.fromJson(Map<String, dynamic> json) {
    return ReturnResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class GetInformListModel {
  String message = '';
  String code = '';
  final List<GetInform> list;

  GetInformListModel({
    required this.code,
    required this.message,
    required this.list,
  });

  factory GetInformListModel.fromJson(Map<String, dynamic> json) {
    List<GetInform>? list = [];
    for (dynamic e in json['data']) {
      GetInform arr = GetInform(
        id: e['id'] ?? '',
        description: e['description'] ?? '',
        image: e['image'] ?? '',
        phoneNumberCallBack: e['phoneNumberCallBack'] ?? '',
        latitude: e['latitude'] ?? '',
        longitude: e['longitude'] ?? '',
        username: e['username'] ?? '',
        phoneNumber: e['phoneNumber'] ?? '',
        workplace: e['workplace'] ?? '',
        subTypeName: e['subTypeName'] ?? '',
        date: e['date'] ?? '',
        updateDate: e['updateDate'],
        status: e['status'] ?? '',
      );
      list.add(arr);
    }

    return GetInformListModel(
      code: json['code'],
      message: json['message'],
      list: list,
    );
  }
}

class GetInform {
  final String id;
  final String description;
  final String image;
  final String phoneNumberCallBack;
  final String latitude;
  final String longitude;
  String username = '';
  String phoneNumber = '';
  String workplace = '';
  final String subTypeName;
  final String date;
  final String updateDate;
  final String status;

  GetInform({
    required this.id,
    required this.description,
    required this.image,
    required this.phoneNumberCallBack,
    required this.latitude,
    required this.longitude,
    required this.username,
    required this.workplace,
    required this.phoneNumber,
    required this.subTypeName,
    required this.date,
    required this.updateDate,
    required this.status,
  });

  factory GetInform.fromJson(Map<String, dynamic> json) {
    return GetInform(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      phoneNumberCallBack: json['phoneNumberCallBack'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      workplace: json['workplace'],
      subTypeName: json['subTypeName'],
      date: json['date'],
      updateDate: json['updateDate'],
      status: json['status'],
    );
  }
}

class GetInformByIdModel {
  String? message;
  String? code;
  String? id;
  String? description;
  List<GetInformByIdImage>? images;
  String? phoneNumberCallBack;
  String? latitude;
  String? longitude;
  String? userId;
  String? username;
  String? workplace;
  String? subTypeName;
  String? date;
  String? status;

  GetInformByIdModel({
    this.code,
    this.message,
    this.id,
    this.description,
    this.images,
    this.phoneNumberCallBack,
    this.latitude,
    this.longitude,
    this.userId,
    this.username,
    this.workplace,
    this.subTypeName,
    this.date,
    this.status,
  });

  factory GetInformByIdModel.fromJson(Map<String, dynamic> json) {
    List<GetInformByIdImage>? images = [];

    if (json['data']['image'] != null) {
      for (dynamic e in json['data']['image']) {
        GetInformByIdImage arr = GetInformByIdImage(
          imageId: e['ImageId'] ?? '',
          image: e['Image'] ?? '',
        );
        images.add(arr);
      }
    }

    return GetInformByIdModel(
      code: json['code'],
      message: json['message'],
      id: json['data']['id'],
      description: json['data']['description'],
      images: images,
      phoneNumberCallBack: json['data']['phoneNumberCallBack'],
      latitude: json['data']['latitude'],
      longitude: json['data']['longitude'],
      userId: json['data']['userId'],
      username: json['data']['username'],
      workplace: json['data']['workplace'],
      subTypeName: json['data']['subTypeName'],
      date: json['data']['date'],
      status: json['data']['status'],
    );
  }
}

class GetInformById {
  final String id;
  final String description;
  final List<GetInformByIdImage> images;
  final String phoneNumberCallBack;
  final String latitude;
  final String longitude;
  String username = '';
  String workplace = '';
  final String subTypeName;
  final String date;
  final String status;

  GetInformById({
    required this.id,
    required this.description,
    required this.images,
    required this.phoneNumberCallBack,
    required this.latitude,
    required this.longitude,
    required this.username,
    required this.workplace,
    required this.subTypeName,
    required this.date,
    required this.status,
  });

  factory GetInformById.fromJson(Map<String, dynamic> json) {
    List<GetInformByIdImage>? images = [];
    for (dynamic e in json['data']['image']) {
      GetInformByIdImage arr = GetInformByIdImage(
        imageId: e['ImageId'] ?? '',
        image: e['Image'] ?? '',
      );
      images.add(arr);
    }

    return GetInformById(
      id: json['id'],
      description: json['description'],
      images: images,
      phoneNumberCallBack: json['phoneNumberCallBack'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      username: json['username'],
      workplace: json['workplace'],
      subTypeName: json['subTypeName'],
      date: json['date'],
      status: json['status'],
    );
  }
}

class GetInformByIdImage {
  final String imageId;
  final String image;

  GetInformByIdImage({
    required this.imageId,
    required this.image,
  });

  factory GetInformByIdImage.fromJson(Map<String, dynamic> json) {
    return GetInformByIdImage(
      imageId: json['imageId'],
      image: json['image'],
    );
  }
}
