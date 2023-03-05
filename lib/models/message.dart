import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String senderId;
  final String receiverId;
  final String message;
  DateTime sentTime;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'sentTime': sentTime.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      sentTime: DateTime.fromMillisecondsSinceEpoch(map['sentTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
