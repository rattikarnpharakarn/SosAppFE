import 'package:flutter/foundation.dart';
import 'package:sos/src/chats/model/message.dart';

class ChatsProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
