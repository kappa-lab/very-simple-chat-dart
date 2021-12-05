import 'dart:convert';
import "dart:io";

import 'dart:typed_data';

import 'protocol/protocol.dart';

const int PORT = 8080;

void startServer() {
  ServerSocket.bind("localhost", PORT)
    ..then((ServerSocket ss) {
      print("[Server Start]");

      ss.listen((socket) => initConnection(socket));
    });
}

void initConnection(Socket socket) {
  print("[Init Connection] ---> ");
  var greetingMessage = {"connId": 1, "roomId": 1, "member": []};
  Protocol.Write(socket, jsonEncode(greetingMessage).codeUnits);

  socket.listen(
    (data) {
      var newData = Uint8List(data.length + 2)
        ..setAll(0, "-".codeUnits)
        ..setAll(1, data)
        ..setAll(data.length, "]".codeUnits);
      socket.add(newData);
    },
    onDone: () => {print("on done")},
  );
}
