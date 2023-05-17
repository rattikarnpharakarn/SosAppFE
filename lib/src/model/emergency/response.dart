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
        statusChat: e['statusChat'] ?? '',
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
  final bool statusChat;

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
    required this.statusChat,
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
      statusChat: json['statusChat'],
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
  final bool statusChat;

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
    required this.statusChat,
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
      statusChat: json['statusChat'],
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

// Type And SubType
class GetTypeListModel {
  String message = '';
  String code = '';
  final List<GetType> data;

  GetTypeListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetTypeListModel.fromJson(Map<String, dynamic> json) {
    List<GetType>? list = [];
    for (dynamic type in json['data']) {
      GetType arr = GetType(
        id: type['id'] ?? "",
        createdAt: type['createdAt'] ?? "",
        updatedAt: type['updatedAt'] ?? "",
        nameType: type['nameType'] ?? "",
        imageType: type['imageType'] ?? "",
        deletedBy: type['deletedBy'] ?? "",
        getSubType: [],
      );
      list.add(arr);
    }

    return GetTypeListModel(
      code: json['code'],
      message: json['message'],
      data: list,
    );
  }
}

class GetTypeByIdModel {
  String message = '';
  String code = '';
  final GetType data;

  GetTypeByIdModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetTypeByIdModel.fromJson(Map<String, dynamic> json) {
    List<GetSubType>? subTypeList = [];
    for (dynamic sub in json['data']['subTypeRes']) {
      GetSubType getSubType = GetSubType(
        id: sub['id'] ?? "",
        createdAt: sub['createdAt'] ?? "",
        deletedBy: sub['deletedBy'] ?? "",
        updatedAt: sub['updatedAt'] ?? "",
        nameSubType: sub['nameSubType'] ?? "",
        imageSubType: sub['imageSubType'] ?? "",
      );

      subTypeList.add(getSubType);
    }

    GetType getType = GetType(
      id: json['id'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      nameType: json['nameType'] ?? "",
      imageType: json['imageType'] ?? "",
      deletedBy: json['deletedBy'] ?? "",
      getSubType: subTypeList,
    );

    return GetTypeByIdModel(
      code: json['code'],
      message: json['message'],
      data: getType,
    );
  }
}

class GetType {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String nameType;
  final String imageType;
  final String deletedBy;
  final List<GetSubType>? getSubType;

  GetType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.nameType,
    required this.imageType,
    required this.deletedBy,
    required this.getSubType,
  });

  factory GetType.fromJson(Map<String, dynamic> json) {
    List<GetSubType>? subtype = [];
    for (dynamic sub in json['subTypeRes']) {
      print(sub['id']);
      print(sub['createdAt']);
      print(sub['updatedAt']);
    }

    return GetType(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      nameType: json['nameType'],
      imageType: json['imageType'],
      deletedBy: json['deletedBy'],
      getSubType: subtype,
    );
  }
}

class GetSubTypeListModel {
  String message = '';
  String code = '';
  final List<GetSubType> data;

  GetSubTypeListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetSubTypeListModel.fromJson(Map<String, dynamic> json) {
    List<GetSubType>? list = [];
    for (dynamic type in json['data']) {
      GetSubType arr = GetSubType(
        id: type['id'] ?? "",
        createdAt: type['createdAt'] ?? "",
        updatedAt: type['updatedAt'] ?? "",
        nameSubType: type['nameSubType'] ?? "",
        imageSubType: type['imageSubType'] ?? "",
        deletedBy: type['deletedBy'] ?? "",
      );
      list.add(arr);
    }

    return GetSubTypeListModel(
      code: json['code'],
      message: json['message'],
      data: list,
    );
  }
}

class GetSubType {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String nameSubType;
  final String imageSubType;
  final String deletedBy;

  GetSubType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.nameSubType,
    required this.imageSubType,
    required this.deletedBy,
  });

  factory GetSubType.fromJson(Map<String, dynamic> json) {
    return GetSubType(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      nameSubType: json['nameSubType'],
      imageSubType: json['imageSubType'],
      deletedBy: json['deletedBy'],
    );
  }
}
