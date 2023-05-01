class ReturnResponse {
  final String message;
  final String code;
  final data;

  ReturnResponse({
    required this.code,
    required this.message,
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

class GetMessageModel {
  final String message;
  final String code;
  final int total;
  final List<GetMessageList> list;

  GetMessageModel({
    required this.code,
    required this.message,
    required this.total,
    required this.list,
  });

  factory GetMessageModel.fromJson(Map<String, dynamic> json) {
    List<GetMessageList>? list = [];
    for (dynamic json in json['data']) {
      GetMessageList arr = GetMessageList(
        id: json['id'],
        roomChatID: json['roomChatID'],
        message: json['message'],
        senderUserId: json['senderUserId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
      list.add(arr);
    }

    return GetMessageModel(
      code: json['code'],
      message: json['message'],
      total: json['total'],
      list: list,
    );
  }
}

class GetMessageList {
  final int id;
  final int roomChatID;
  final String message;
  final int senderUserId;
  final String createdAt;
  final String updatedAt;

  GetMessageList({
    required this.id,
    required this.roomChatID,
    required this.message,
    required this.senderUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetMessageList.fromJson(Map<String, dynamic> json) {
    return GetMessageList(
      id: json['id'],
      roomChatID: json['roomChatID'],
      message: json['message'],
      senderUserId: json['senderUserId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class GetMemberRoomChatModel {
  final String message;
  final String code;
  final String roomChatID;
  final String roomName;
  final String ownerId;
  final List<GetMemberRoomChatList> memberRoomChat;

  GetMemberRoomChatModel({
    required this.code,
    required this.message,
    required this.roomChatID,
    required this.roomName,
    required this.ownerId,
    required this.memberRoomChat,
  });

  factory GetMemberRoomChatModel.fromJson(Map<String, dynamic> json) {
    List<GetMemberRoomChatList>? list = [];
    for (dynamic json in json['data']['memberRoomChat']) {
      GetMemberRoomChatList arr = GetMemberRoomChatList(
        userId: json['userId'],
      );
      list.add(arr);
    }

    return GetMemberRoomChatModel(
      code: json['code'],
      message: json['message'],
      roomChatID: json['data']['roomChatID'],
      roomName: json['data']['roomName'],
      ownerId: json['data']['ownerId'],
      memberRoomChat: list,
    );
  }
}

class GetMemberRoomChatList {
  final int userId;

  GetMemberRoomChatList({
    required this.userId,
  });

  factory GetMemberRoomChatList.fromJson(Map<String, dynamic> json) {
    return GetMemberRoomChatList(
      userId: json['userId'],
    );
  }
}


class GetMemberRoomChatShow {
  final int userId;
  final String firstName;
  final String lastName;


  GetMemberRoomChatShow({
    required this.userId,
    required this.firstName,
    required this.lastName,
  });

  factory GetMemberRoomChatShow.fromJson(Map<String, dynamic> json) {
    return GetMemberRoomChatShow(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
