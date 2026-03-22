class Message {
  String content;
  DateTime timestamp;
  String senderId;
  String senderName;

  Message(
      {required this.content, required this.timestamp, required this.senderId, required this.senderName});
}