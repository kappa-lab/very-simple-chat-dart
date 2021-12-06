import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import './room.dart';
import 'command/command.dart';
import 'protocol/protocol.dart';

class ConnectionCtrl {
  final _id;
  get id => _id;

  Socket _socket;

  ConnectionCtrl(this._id, this._socket, Room room) {
    _socket.listen(
      (data) => _readMessage(data, room),
      onDone: () => {_leave(room)},
    );
  }

  void _leave(Room room) {
    print("[ConnCtrl($_id) Leave]");

    room.removeListener(_id);

    final json = jsonEncode({
      "leaveId": _id,
      "member": room.getIds().add(1),
    });

    room.broadcast(json);
  }

  void _readMessage(Uint8List data, Room room) {
    final msg = String.fromCharCodes(Protocol.Read(data));
    final Command cmd = Command.fromJson(jsonDecode(msg));
    print("[ConnCtrl($_id) Read]: $msg");

    final json = jsonEncode({
      "sender": _id,
      "message": cmd.message,
    });

    if (cmd.isBroadcast())
      room.broadcast(json);
    else
      room.unicast(cmd.target, json);
  }

  void _eventListener(String msg) => Protocol.Write(_socket, msg.codeUnits);
  get eventListener => _eventListener;
}
