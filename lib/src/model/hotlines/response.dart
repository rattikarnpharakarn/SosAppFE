class ReturnResponse {
  String message = '';
  String code = '';
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

class GetHotlineListModel {
  String message = '';
  String code = '';
  final List<GetHotline> list;

  GetHotlineListModel({
    required this.code,
    required this.message,
    required this.list,
  });

  factory GetHotlineListModel.fromJson(Map<String, dynamic> json) {
    List<GetHotline>? list = [];
    for (dynamic e in json['data']) {
      GetHotline arr = GetHotline(
        id: e['id'],
        number: e['number'],
        description: e['description'],
      );
      list.add(arr);
    }

    return GetHotlineListModel(
      code: json['code'],
      message: json['message'],
      list: list,
    );
  }
}

class GetHotline {
  final int id;
  final String number;
  final String description;

  GetHotline({
    required this.id,
    required this.number,
    required this.description,
  });

  factory GetHotline.fromJson(Map<String, dynamic> json) {
    return GetHotline(
      id: json['id'],
      number: json['name'],
      description: json['description'],
    );
  }
}
