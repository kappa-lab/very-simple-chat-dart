import 'dart:io';

import './room.dart';

class ConnectionCtrl {
  int _id;
  int get id => _id;

  late int _eventListener;
  int get eventListener => _eventListener;

  ConnectionCtrl(this._id) {
    _eventListener = 0;
  }

  void HandleEventListener(Socket sok) {}
  void ReadMessage(Room myRoom, Socket sok) {}
}
