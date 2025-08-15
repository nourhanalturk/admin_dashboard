class MessageModel {
  final String message;
  final bool isSender;

  MessageModel({required this.message, required this.isSender});

  factory MessageModel.fromJson(Map<String, dynamic> json, String currentUid) {
    String senderId = json['sender_id'].toString();
    return MessageModel(
      message: json['content'] ?? '',
      isSender: senderId == currentUid,
    );
  }
}
