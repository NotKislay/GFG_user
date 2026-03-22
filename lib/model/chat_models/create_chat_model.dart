class ChatCreationResponse {
  final bool status;
  final String message;
  final Chat chat;

  ChatCreationResponse({
    required this.status,
    required this.message,
    required this.chat,
  });

  factory ChatCreationResponse.fromJson(Map<String, dynamic> json) {
    return ChatCreationResponse(
      status: json['status'],
      message: json['message'],
      chat: Chat.fromJson(json['chat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'chat': chat.toJson(),
    };
  }
}

class Chat {
  final int id;
  final String name;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chat({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class CreateChatRequest {
  final String name;
  final String service;

  CreateChatRequest({
    required this.name,
    required this.service
  });

  factory CreateChatRequest.fromJson(Map<String, dynamic> json) {
    return CreateChatRequest(
      name: json['name'],
      service: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': service
    };
  }
}
