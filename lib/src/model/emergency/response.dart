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
  final List<GetInfrom> list;

  GetInformListModel({
    required this.code,
    required this.message,
    required this.list,
  });

  factory GetInformListModel.fromJson(Map<String, dynamic> json) {
    List<GetInfrom>? list = [];
    for (dynamic e in json['data']) {
      GetInfrom arr = GetInfrom(
        id: e['id'] ?? '',
        description: e['description'] ?? '',
        image: e['image'] ?? '',
        phoneNumberCallBack: e['phoneNumberCallBack'] ?? '',
        latitude: e['latitude'] ?? '',
        longitude: e['longitude'] ?? '',
        username: e['username'] ?? '',
        workplace: e['workplace'] ?? '',
        subTypeName: e['subTypeName'] ?? '',
        date: e['date'] ?? '',
        status:  e['status'] ?? '',
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

class GetInfrom {
  final String id;
  final String description;
  final String image;
  final String phoneNumberCallBack;
  final String latitude;
  final String longitude;
  String username = '';
  String workplace = '';
  final String subTypeName;
  final String date;
  final String status;

  GetInfrom({
    required this.id,
    required this.description,
    required this.image,
    required this.phoneNumberCallBack,
    required this.latitude,
    required this.longitude,
    required this.username,
    required this.workplace,
    required this.subTypeName,
    required this.date,
    required this.status,
  });

  factory GetInfrom.fromJson(Map<String, dynamic> json) {
    return GetInfrom(
      id: json['id'],
      description: json['description'],
      image: json['image'],
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
