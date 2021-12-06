import 'dart:io';

import 'connectionCtrl.dart';

class Room {
  final int _id;
  int get id => _id;

  int _counter = 0;
  int generateId() => _counter++;
  final Map<int, Function(String message)> _listeners = Map();

  Room(this._id);

  broadcast(String message) {
    for (var item in _listeners.values) {
      item.call(message);
    }
  }

  unicast(int reciever, String message) {
    _listeners[reciever]?.call(message);
  }

  addListener(int id, Function(String message) listener) {
    _listeners[id] = listener;
  }

  removeListener(int id) {
    _listeners.remove(id);
  }

  ConnectionCtrl createConnectionCtrl(Socket socket, Room room) {
    return ConnectionCtrl(generateId(), socket, room);
  }

  Set<int> getIds() {
    return _listeners.keys.toSet();
  }
}
