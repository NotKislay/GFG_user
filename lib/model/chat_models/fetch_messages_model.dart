import 'dart:convert';

class FetchMessagesModel {
  final int total;
  final int lastPage;
  final String? lastMessageId;
  final List<MessageData> messages;

  FetchMessagesModel({
    required this.total,
    required this.lastPage,
    required this.lastMessageId,
    required this.messages,
  });

  factory FetchMessagesModel.fromJson(Map<String, dynamic> json) {
    return FetchMessagesModel(
      total: json['total'],
      lastPage: json['last_page'],
      lastMessageId: json['last_message_id'],
      messages: List<MessageData>.from(
          json['messages'].map((message) => MessageData.fromJson(message))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'last_page': lastPage,
      'last_message_id': lastMessageId,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class MessageData {
  String? id;
  int? chatId;
  int? fromId;
  int? toId;
  String? body;
  String? type;
  MessageAttachment? attachment;
  int? seen;
  String? createdAt;
  String? updatedAt;

  MessageData({
    required this.id,
    required this.chatId,
    required this.fromId,
    required this.toId,
    required this.body,
    this.attachment,
    this.type,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    final MessageAttachment? attachment = json['attachment'] != null
        ? MessageAttachment.fromJson(jsonDecode(json['attachment']))
        : null;
    return MessageData(
      id: json['id'],
      chatId: json['chat_id'],
      fromId: json['from_id'],
      toId: json['to_id'],
      body: json['body'],
      attachment: attachment,
      seen: json['seen'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'from_id': fromId,
      'to_id': toId,
      'body': body,
      'attachment': attachment,
      'seen': seen,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
    };
  }
}

class MessageAttachment {
  String? oldName;
  String? newName;
  String? type;
  String? fileSize;
  String? pages;
  bool? isDownloaded;

  MessageAttachment(
      {required this.newName,
      required this.oldName,
      this.type,
      this.isDownloaded,
      this.fileSize,
      this.pages});

  factory MessageAttachment.fromJson(Map<String, dynamic> json) {
    return MessageAttachment(
      newName: json['new_name'],
      oldName: json['old_name'],
    );
  }

  @override
  String toString() {
    return "oldname = $oldName, newname = $newName, filesize = $fileSize, pages = $pages, isdownloaded = ${isDownloaded}";
  }
}

class FetchMessagesRequest {
  final int chatId;

  FetchMessagesRequest({
    required this.chatId,
  });

  factory FetchMessagesRequest.fromJson(Map<String, dynamic> json) {
    return FetchMessagesRequest(
      chatId: json['chat_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
    };
  }
}
