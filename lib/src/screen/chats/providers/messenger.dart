import 'package:flutter/foundation.dart';
import 'package:sos/src/screen/chats/model/message.dart';

class ChatsProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  addNewMessage(Message message,bool check) {
    if (check) {
      _messages.insert(0, message);
    }else{
      _messages.add(message);
    }
    notifyListeners();
  }
}
