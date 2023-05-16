class Inform {
  String description;
  List<String> images;
  String phoneNumberCallBack;
  String latitude;
  String longitude;
  String userID;
  int subTypeID;

  Inform({
    required this.description,
    required this.images,
    required this.phoneNumberCallBack,
    required this.latitude,
    required this.longitude,
    required this.userID,
    required this.subTypeID,
  });

  Map toJson() {
    return {
      'description': description,
      'images': images,
      'phoneNumberCallBack': phoneNumberCallBack,
      'latitude': latitude,
      'longitude': longitude,
      'userID': userID,
      'subTypeID': subTypeID,
    };
  }
}

class UpdateInform {
  int opsID;
  int status;
  bool statusChat;

  UpdateInform({
    required this.opsID,
    required this.status,
    required this.statusChat,
  });

  Map toJson() {
    return {
      'opsID': opsID,
      'status': status,
      'statusChat': statusChat,
    };
  }
}
