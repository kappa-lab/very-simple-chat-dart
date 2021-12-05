import 'connectionCtrl.dart';

class Room {
  int _id;
  int get id => _id;

  int _counter = 0;
  List<int> _listeners = [];

  Room(this._id);

  broadcast(String message) {}
  unicast(int reciever, String message) {}
  addListener(int id, int listener) {}
  removeListener(int id) {}

  int generateId() => _counter++;

  ConnectionCtrl createConnectionCtrl() {
    return ConnectionCtrl(generateId());
  }

  List<int> getIds() {
    return _listeners;
  }
}
