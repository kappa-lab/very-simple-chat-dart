class Command {
  final int target;
  final String message;

  static const BroadcastTarget = 255;

  bool isBroadcast() => target == BroadcastTarget;

  Command(this.target, this.message);

  Map<String, dynamic> toJson() => {"target": target, "message": message};
  Command.fromJson(Map<String, dynamic> json)
      : target = json['target'],
        message = json['message'];
}
