import 'dart:convert';
import 'dart:ffi';
import "dart:io";
import "dart:async";

import 'dart:typed_data';

const int PORT = 8080;

void server() {
  var fss = ServerSocket.bind("localhost", PORT);
  fss.then((ServerSocket ss) {
    print("[Server Start]");

    ss.listen((socket) {
      print("[Init Connection] ---> ");

      var greetingMessage = {"connId": 1, "roomId": 1, "member": []};
      socket.add(jsonEncode(greetingMessage).codeUnits);

      socket.listen(
        (data) {
          print("dat");
          var newData = Uint8List(data.length + 2)
            ..setAll(0, "[".codeUnits)
            ..setAll(1, data)
            ..setAll(data.length, "]".codeUnits);
          socket.add(newData);
        },
        onDone: () => {print("on done")},
      );
    });
  });
}

void main() {
  server();
  // client();
}
