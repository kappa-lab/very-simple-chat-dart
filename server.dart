import 'dart:convert';
import "dart:io";

import 'dart:typed_data';

import 'protocol/protocol.dart';
import 'room.dart';

const int PORT = 8080;

void startServer() {
  final room = Room(0);
  ServerSocket.bind("localhost", PORT)
    ..then((ServerSocket ss) {
      print("[Server Start]");

      ss.listen((socket) => initConnection(socket, room));
    });
}

void initConnection(Socket socket, Room room) {
  print("[Init Connection] ---> ");
  final connCtrl = room.createConnectionCtrl(socket, room);
  final greetingMessage = {
    "connId": connCtrl.id,
    "roomId": room.id,
    "member": room.getIds().add(1)
  };
  final json = jsonEncode(greetingMessage);

  Protocol.Write(socket, json.codeUnits);
  room.broadcast(json);
  room.addListener(connCtrl.id, connCtrl.eventListener);
}
