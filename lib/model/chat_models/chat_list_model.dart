class ChatsListModel {
  final bool status;
  final String message;
  final List<ChatData> data;

  ChatsListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChatsListModel.fromJson(Map<String, dynamic> json) {
    return ChatsListModel(
      status: json['status'],
      message: json['message'],
      data: List<ChatData>.from(
          json['data'].map((chat) => ChatData.fromJson(chat))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((chat) => chat.toJson()).toList(),
    };
  }
}

class ChatData {
  bool? isLast = false;
  final int id;
  final String name;
  final String? tag;
  final int userId;
  final int? backendId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? serviceId;
  final String? unseenCount;

  ChatData(
      {this.isLast,
      required this.id,
      required this.name,
      required this.tag,
      required this.userId,
      this.backendId,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.serviceId,
      required this.unseenCount});

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
        id: json['id'],
        name: json['name'],
        tag: json['tag'],
        userId: json['user_id'],
        backendId: json['backend_id'],
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        serviceId: json['service_id'],
        unseenCount: json['unseen_count']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tag': tag,
      'user_id': userId,
      'backend_id': backendId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'service_id': serviceId,
      'unseen_count': unseenCount
    };
  }
}
