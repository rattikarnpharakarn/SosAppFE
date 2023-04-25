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

class GetChatListModel {
  String message = '';
  String code = '';
  int total;
  final List<GetChat> list;

  GetChatListModel({
    required this.code,
    required this.message,
    required this.total,
    required this.list,
  });

  factory GetChatListModel.fromJson(Map<String, dynamic> json) {
    List<GetChat>? list = [];
    for (dynamic json in json['data']) {
      GetChat arr = GetChat(
        roomChatID: json['roomChatID'],
        roomName: json['roomName'],
        ownerId: json['ownerId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        // deletedAT: json['deletedAT'],
        deleteBy: json['deleteBy'],
      );
      list.add(arr);
    }

    return GetChatListModel(
      code: json['code'],
      message: json['message'],
      total: json['total'],
      list: list,
    );
  }
}

class GetChat {
  final String roomChatID;
  final String roomName;
  final String ownerId;
  final String createdAt;
  final String updatedAt;
  // final String deletedAT;
  final String deleteBy;

  GetChat({
    required this.roomChatID,
    required this.roomName,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    // required this.deletedAT,
    required this.deleteBy,
  });

  factory GetChat.fromJson(Map<String, dynamic> json) {
    return GetChat(
      roomChatID: json['roomChatID'],
      roomName: json['roomName'],
      ownerId: json['ownerId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // deletedAT: json['deletedAT'],
      deleteBy: json['deleteBy'],
    );
  }
}
