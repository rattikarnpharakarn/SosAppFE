class NotificationModel {
  String description;
  String phoneNumberCallBack;
  String latitude;
  String longitude;
  String username;
  String type;

  NotificationModel({
    required this.description,
    required this.phoneNumberCallBack,
    required this.latitude,
    required this.longitude,
    required this.username,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> data) {
    return NotificationModel(
      description: data['description'],
      phoneNumberCallBack: data['phoneNumberCallBack'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      username: data['username'],
      type: data['type'],
    );
  }
}
