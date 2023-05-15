import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sos/src/model/accounts/user.dart';
import 'package:sos/src/provider/common/model.dart';
import 'package:sos/src/provider/common/notificationApp.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/screen/chats/model/message.dart';

Future<IO.Socket> connectSocket(UserInfo data) async {
  late IO.Socket _socket;
  _socket = IO.io(
    urlWsMessenger+ '0',
    IO.OptionBuilder().setTransports(['websocket']).setQuery({
      'username': data.firstName + " " + data.lastName,
    }).build(),
  );
  _socket.connect();
  return _socket;
}