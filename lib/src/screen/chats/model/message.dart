class Message {
  final String message;
  final String image;
  final String senderUsername;
  final DateTime sentAt;

  Message({
    required this.message,
    required this.image,
    required this.senderUsername,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'],
      image: message['image'],
      senderUsername: message['senderUsername'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(message['sentAt']),
    );
  }
}
