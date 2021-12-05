import "dart:io";
import "dart:async";

import '../protocol/protocol.dart';

const int PORT = 8080;

void main() {
  print("[Client Start]");
  Future<Socket> fs = Socket.connect("localhost", PORT);
  fs.then((Socket s) {
    stdin.listen((List<int> data) => parseInput(data, s));
    s.listen((data) => print(new String.fromCharCodes(Protocol.Read(data))));
    Future.delayed(const Duration(seconds: 1), () {
      sendGreeting(s);
    });
  });
}

void sendGreeting(Socket s) {
  print("[sendGreeting]");
  s.add("Hello everybody".codeUnits);
}

void parseInput(List<int> data, Socket s) => s.add(data);
