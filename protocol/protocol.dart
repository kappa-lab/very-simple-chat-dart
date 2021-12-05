import 'dart:io';

import 'dart:typed_data';

/**
* Protocol Structure
* |----Header(1byte)-----|-----Body(max255byte)-----|
* |     BodyLength       |          Body            |
* |______________________|__________________________|
 */
class Protocol {
  static List<int> Read(Uint8List data) {
    return data.skip(1).toList();
  }

  static void Write(Socket socket, List<int> body) {
    var data = [body.length]..addAll(body);
    socket.add(data);
  }
}
